import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../repositories/savings/abstract_savings_repository.dart';
import '../../../repositories/savings/models/saving.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../auth/blocs/auth_cubit.dart';
import '../../statistic/blocs/statistic_cubit.dart';

part 'saving_cubit.freezed.dart';
part 'saving_state.dart';

class SavingCubit extends Cubit<SavingState> {
  final FirebaseFirestore _firestore;
  final AbstractSavingsRepository _savingsRepository;

  final StatisticCubit _statisticCubit;
  final AuthCubit _authCubit;

  StreamSubscription? _savingSub;
  late final StreamSubscription _authSub;

  SavingCubit(
    this._savingsRepository,
    this._firestore,
    this._statisticCubit,
    this._authCubit,
  ) : super(const SavingState.loading()) {
    _authSub = _authCubit.stream.listen(_onAuthChanged);
    _onAuthChanged(_authCubit.state);
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

  @override
  Future<void> close() {
    _savingSub?.cancel();
    _authSub.cancel();
    return super.close();
  }

  Future<void> loadSavings(String userId) async {
    try {
      if (state is! _Loaded) {
        emit(const SavingState.loading());
      }

      final savings = await _savingsRepository.getSavingsList(userId: userId);

      emit(SavingState.loaded(savings: savings));
    } catch (e) {
      emit(SavingState.error(e.toString()));
    }
  }

  Future<void> createSaving({
    required String goal,
    required int total,
  }) async {
    try {
      if (state is! _Loaded) {
        emit(const SavingState.loading());
      }
      if (goal.isEmpty || total == 0) {
        return;
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

      _statisticCubit.deleteStatistic(saving);
    } catch (e) {
      emit(SavingState.error(e.toString()));
    }
  }

  Future<void> updateSaving({
    required String savingId,
    required int money,
    required int moneyForStatistic,
  }) async {
    try {
      if (state is! _Loaded) {
        emit(const SavingState.loading());
      }

      await _savingsRepository.updateSaving(
        savingId: savingId,
        money: money,
      );

      _statisticCubit.addStatistic(
        money: moneyForStatistic,
        savingId: savingId,
      );
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

  void _onAuthChanged(AuthState event) async {
    event.maybeWhen(
      loggedIn: (user) {
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
