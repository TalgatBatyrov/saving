import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:saving/features/savings/repository/models/saving/saving.dart';

import 'abstract_savings_repository.dart';

class SavingsRepository implements AbstractSavingsRepository {
  final FirebaseFirestore firestore;

  final Dio dio;

  SavingsRepository({
    required this.dio,
    required this.firestore,
  });

  @override
  Future<List<Saving>> getSavingsList({required String userId}) async {
    List<Saving> savingList = [];
    try {
      final saving = firestore.collection('savings');
      final response = await saving.where('userId', isEqualTo: userId).get();

      savingList = response.docs.map((e) {
        return Saving.fromJson(e.data());
      }).toList();
    } catch (e) {
      rethrow;
    }

    return savingList;
  }

  @override
  Future<void> createSaving({
    required String goal,
    required int total,
  }) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final savingsPath = 'users/$userId/savings';
    final savingCollection = firestore.collection(savingsPath);
    final docId = savingCollection.doc().id;

    Saving saving = Saving(
      id: docId,
      goal: goal,
      total: total,
      current: 0,
      userId: userId,
    );

    savingCollection.doc(docId).set(saving.toJson());
  }

  @override
  Future<void> deleteSaving(Saving saving) async {
    final savingsPath = 'users/${saving.userId}/savings';
    final savingCollection = firestore.collection(savingsPath);

    savingCollection.doc(saving.id).delete();
  }

  @override
  Future<void> updateSaving({
    required String savingId,
    required int money,
  }) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final savingsPath = 'users/$userId/savings';
    final savingCollection = firestore.collection(savingsPath);

    // current = transaction sum + current

    savingCollection.doc(savingId).update({'current': money});
  }

  // @override
  // Future<void> updateSavingImage({
  //   required String savingId,
  //   required String? image,
  // }) async {
  //   final userId = FirebaseAuth.instance.currentUser!.uid;
  //   final savingsPath = 'users/$userId/savings';
  //   final savingCollection = firestore.collection(savingsPath);

  //   savingCollection.doc(savingId).update({'image': image});
  // }

  @override
  Future<void> changeSavingTitle({
    required String savingId,
    required String newTitle,
  }) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final savingsPath = 'users/$userId/savings';
    final savingCollection = firestore.collection(savingsPath);
    savingCollection.doc(savingId).update({'goal': newTitle});
  }
}
