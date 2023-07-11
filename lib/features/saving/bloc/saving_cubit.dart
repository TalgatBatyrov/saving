import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_app/features/saving/bloc/saving_state.dart';
import 'package:flutter_my_app/repositories/savings/abstract_savings_repository.dart';
import '../../../repositories/savings/models/saving.dart';

class SavingCubit extends Cubit<SavingState> {
  final FirebaseFirestore _firestore;
  final AbstractSavingsRepository _savingsRepository;

  late final StreamSubscription _savingSub;

  SavingCubit(
    this._savingsRepository,
    this._firestore,
  ) : super(SavingInitial()) {
    final savingsCollection = _firestore.collection('savings');

    _savingSub = savingsCollection.snapshots().listen(_onSavingsChanged);
  }

  void _onSavingsChanged(QuerySnapshot<Map<String, dynamic>> event) {
    final savingList = event.docs.map((e) {
      return Saving.fromJson(e.data());
    }).toList();

    if (savingList.isEmpty) {
      emit(SavingEmpty());
    } else {
      emit(SavingLoaded(savings: savingList));
    }
  }

  @override
  Future<void> close() {
    _savingSub.cancel();
    return super.close();
  }

  Future<void> loadSavings() async {
    try {
      if (state is! SavingLoaded) {
        emit(SavingLoading());
      }

      final savings = await _savingsRepository.getSavingsList();

      emit(SavingLoaded(savings: savings));
    } catch (e) {
      emit(SavingError(e.toString()));
    }
  }

  Future<void> createSaving({
    required String goal,
    required int total,
  }) async {
    try {
      if (state is! SavingLoaded) {
        emit(SavingLoading());
      }

      await _savingsRepository.createSaving(
        goal: goal,
        total: total,
      );
    } catch (e) {
      emit(SavingError(e.toString()));
    }
  }

  Future<void> deleteSaving(String id) async {
    try {
      if (state is! SavingLoaded) {
        emit(SavingLoading());
      }

      await _savingsRepository.deleteSaving(id);
    } catch (e) {
      emit(SavingError(e.toString()));
    }
  }

  Future<void> updateSaving(Saving saving) async {
    try {
      if (state is! SavingLoaded) {
        emit(SavingLoading());
      }

      final isCurrentMoreThanTotal = saving.current >= saving.total;

      final updatedSaving = isCurrentMoreThanTotal
          ? saving.copyWith(
              remaining: 0,
              isCompleted: true,
            )
          : saving.copyWith(
              remaining: saving.remaining <= 0
                  ? saving.total
                  : saving.total - saving.current,
              isCompleted: false,
            );

      await _savingsRepository.updateSaving(updatedSaving);
    } catch (e) {
      emit(SavingError(e.toString()));
    }
  }
}
