import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_app/features/saving/bloc/statistic/statistic_state.dart';
import 'package:flutter_my_app/repositories/savings/models/statistic/statistic.dart';

class StatisticCubit extends Cubit<StatisticState> {
  final FirebaseFirestore _firestore;

  StatisticCubit(this._firestore) : super(StatisticInitial());

  void load(String savingId) async {
    final savingCollection = _firestore.collection('statistics');

    emit(StatisticLoading());

    final response =
        await savingCollection.where('savingId', isEqualTo: savingId).get();

    final statisticList = response.docs.map((e) {
      return Statistic.fromJson(e.data());
    }).toList();

    emit(StatisticLoaded(statistics: statisticList));
  }

  void add({
    required String savingId,
    required int money,
  }) {
    final savingCollection = _firestore.collection('statistics');

    final docId = savingCollection.doc().id;

    Statistic statistic = Statistic(
      money: money,
      savingId: savingId,
      id: docId,
      date: DateTime.now(),
    );

    savingCollection
        .doc(docId)
        .set(statistic.toJson())
        .then((value) => print("Success add statistic"))
        .catchError(
          (error) => print("Failed to add statistic: $error"),
        );

    if (state is StatisticLoaded) {
      final updatedCart = [...(state as StatisticLoaded).statistics, statistic];
      emit(StatisticLoaded(statistics: updatedCart));
    }
  }
}
