import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:saving/blocs/profile_cubit/profile_cubit.dart';
import 'package:saving/blocs/statistic/statistic_cubit.dart';
import 'package:saving/blocs/statistic_changes/statistic_changes_cubit.dart';

import '../../models/saving/saving.dart';
import '../../repositories/savings/abstract_savings_repository.dart';

part 'saving_cubit.freezed.dart';
part 'saving_state.dart';

class SavingCubit extends Cubit<SavingState> {
  final FirebaseFirestore _firestore;
  final AbstractSavingsRepository _savingsRepository;

  final StatisticCubit _statisticCubit;
  final StatisticChangesCubit _statisticChangesCubit;
  final ProfileCubit _profileCubit;

  StreamSubscription? _savingSub;
  late final StreamSubscription _authSub;
  late final StreamSubscription _statisticChangesSub;

  SavingCubit(
    this._savingsRepository,
    this._firestore,
    this._statisticCubit,
    this._profileCubit,
    this._statisticChangesCubit,
  ) : super(const SavingState.loading()) {
    _authSub = _profileCubit.stream.listen(_onProfileChanged);
    _onProfileChanged(_profileCubit.state);

    _statisticChangesSub =
        _statisticChangesCubit.stream.listen(_onStatisticSignal);
  }

  void _onSavingsChanged(QuerySnapshot<Map<String, dynamic>> event) {
    final savingList = event.docs.map((e) {
      return Saving.fromJson(e.data());
    }).toList();

    if (savingList.isEmpty) {
      return emit(const SavingState.empty());
    }

    emit(SavingState.loaded(savings: savingList));
  }

  void _onStatisticSignal(StatisticChangesState statisticChangesState) {
    statisticChangesState.whenOrNull(
      updated: (statistic) async {
        await _statisticCubit.editStatistic(statistic);

        final summ =
            await _statisticCubit.getStatisticSummary(statistic.savingId);

        await _savingsRepository.updateSaving(
          savingId: statistic.savingId,
          money: summ,
        );
      },
      remowed: (statistic) async {
        await _statisticCubit.deleteStatisticById(statistic);
        final summ =
            await _statisticCubit.getStatisticSummary(statistic.savingId);
        await _savingsRepository.updateSaving(
          savingId: statistic.savingId,
          money: summ,
        );
      },
    );
  }

  @override
  Future<void> close() {
    _savingSub?.cancel();
    _authSub.cancel();
    _statisticChangesSub.cancel();
    return super.close();
  }

  Future<void> createSaving({
    required String goal,
    required int total,
    required String currencyState,
  }) async {
    try {
      if (state is! _Loaded) {
        emit(const SavingState.loading());
      }

      await _savingsRepository.createSaving(
        goal: goal,
        total: total,
      );
    } catch (e) {
      emit(SavingState.error(e.toString()));
    }
  }

  Future<void> deleteSaving(Saving saving) async {
    try {
      if (state is! _Loaded) {
        emit(const SavingState.loading());
      }

      await _savingsRepository.deleteSaving(saving);

      _statisticCubit.deleteStatistics(saving);
    } catch (e) {
      emit(SavingState.error(e.toString()));
    }
  }

  Future<void> updateSaving({
    required String savingId,
    required int moneyForStatistic,
  }) async {
    try {
      if (state is! _Loaded) {
        emit(const SavingState.loading());
      }

      final summ = await _statisticCubit.getStatisticSummary(savingId);

      final addedMoney = moneyForStatistic + summ;

      final noNegative = addedMoney <= 0 ? 0 : addedMoney;

      await _savingsRepository.updateSaving(
        savingId: savingId,
        money: noNegative,
      );

      if (noNegative > 0) {
        _statisticCubit.addStatistic(
          money: moneyForStatistic,
          savingId: savingId,
        );
      } else if (summ > 0) {
        _statisticCubit.addStatistic(
          money: -summ,
          savingId: savingId,
        );
      }
    } catch (e) {
      emit(SavingState.error(e.toString()));
    }
  }

  Future<void> changeSavingTitle({
    required String title,
    required String savingId,
  }) async {
    try {
      if (state is! _Loaded) {
        emit(const SavingState.loading());
      }

      await _savingsRepository.changeSavingTitle(
        newTitle: title,
        savingId: savingId,
      );
    } catch (e) {
      emit(SavingState.error(e.toString()));
    }
  }

  void _onProfileChanged(ProfileState event) async {
    event.maybeWhen(
      loaded: (user) {
        final savingsCollection = _firestore.collection(
          'users/${user.id}/savings',
        );
        _savingSub = savingsCollection.snapshots().listen(_onSavingsChanged);
      },
      orElse: () {
        _savingSub?.cancel();
      },
    );
  }
}
