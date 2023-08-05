import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_my_app/repositories/savings/abstract_savings_repository.dart';
import 'package:flutter_my_app/repositories/savings/models/saving.dart';
import 'package:hive_flutter/adapters.dart';

class SavingsRepository implements AbstractSavingsRepository {
  final FirebaseFirestore firestore;

  final Dio dio;
  final Box<Saving> savingsBox;

  SavingsRepository({
    required this.dio,
    required this.savingsBox,
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

      final savingListMap = {for (var e in savingList) e.id: e};

      await savingsBox.putAll(savingListMap);
    } catch (e) {
      savingList = savingsBox.values.toList();
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

    savingCollection
        .doc(docId)
        .set(saving.toJson())
        .then((value) => print("Success add Saving"))
        .catchError(
          (error) => print("Failed to add Saving: $error"),
        );
  }

  @override
  Future<void> deleteSaving(Saving saving) async {
    final savingsPath = 'users/${saving.userId}/savings';
    final savingCollection = firestore.collection(savingsPath);

    savingCollection
        .doc(saving.id)
        .delete()
        .then((value) => print("Saving Deleted"))
        .catchError(
          (error) => print("Failed to delete user: $error"),
        );
  }

  @override
  Future<void> updateSaving(Saving saving) async {
    final savingsPath = 'users/${saving.userId}/savings';
    final savingCollection = firestore.collection(savingsPath);
    savingCollection
        .doc(saving.id)
        .update(saving.toJson())
        .then((value) => print("Saving Updated"))
        .catchError((er) => print("Failed to update Saving: $er"));
  }

  @override
  Future<void> updateSaving2({
    required String savingId,
    required int money,
  }) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final savingsPath = 'users/$userId/savings';
    final savingCollection = firestore.collection(savingsPath);
    savingCollection
        .doc(savingId)
        .update({'current': money <= 0 ? 0 : money})
        .then((value) => print("Saving Updated"))
        .catchError((er) => print("Failed to update Saving: $er"));
  }

  @override
  Future<void> changeSavingTitle({
    required String savingId,
    required String newTitle,
  }) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final savingsPath = 'users/$userId/savings';
    final savingCollection = firestore.collection(savingsPath);
    savingCollection
        .doc(savingId)
        .update({'goal': newTitle})
        .then((value) => print("Saving Updated"))
        .catchError((er) => print("Failed to update Saving: $er"));
  }
}
