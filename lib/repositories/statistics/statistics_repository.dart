import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../savings/models/saving.dart';
import 'abstract_statistics_repository.dart';
import 'models/statistic.dart';

class StatisticsRepository implements AbstractStatisticsRepository {
  final FirebaseFirestore _firestore;

  StatisticsRepository(this._firestore);

  @override
  Future<List<Statistic>> getStatisticsList(Saving saving) async {
    final statisticPath =
        'users/${saving.userId}/savings/${saving.id}/transactions';
    final statisticsCollection = _firestore.collection(statisticPath);

    final response = await statisticsCollection
        .where('savingId', isEqualTo: saving.id)
        .orderBy('date', descending: true)
        .get();

    final statistiscList = response.docs.map((e) {
      return Statistic.fromJson(e.data());
    }).toList();

    return statistiscList;
  }

  @override
  Future<void> addStatistic({
    required String savingId,
    required int money,
  }) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    final statisticPath = 'users/$userId/savings/$savingId/transactions';
    final statisticsCollection = _firestore.collection(statisticPath);

    final docId = statisticsCollection.doc().id;

    Statistic statistic = Statistic(
      money: money,
      savingId: savingId,
      id: docId,
      date: DateTime.now(),
    );

    statisticsCollection.doc(docId).set(statistic.toJson());
  }

  @override
  Future<void> deleteStatistic(Saving saving) async {
    final statisticPath =
        'users/${saving.userId}/savings/${saving.id}/transactions';
    final statisticsCollection = _firestore.collection(statisticPath);

    statisticsCollection
        .where('savingId', isEqualTo: saving.id)
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
  }
}
