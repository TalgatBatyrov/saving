import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter_my_app/repositories/savings/abstract_savings_repository.dart';
import 'package:flutter_my_app/repositories/savings/models/saving.dart';
import 'package:hive_flutter/adapters.dart';

class SavingsRepository implements AbstractSavingsRepository {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final Dio dio;
  final Box<Saving> savingsBox;

  SavingsRepository({
    required this.dio,
    required this.savingsBox,
  });

  @override
  Future<List<Saving>> getSavingsList() async {
    List<Saving> savingList = [];
    try {
      final saving = firestore.collection('savings');

      final response = await saving.get();

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
    final savingCollection = firestore.collection('savings');

    final docId = savingCollection.doc().id;

    Saving saving = Saving(
      id: docId,
      goal: goal,
      remaining: total,
      total: total,
      current: 0,
      isCompleted: false,
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
  Future<void> deleteSaving(String id) async {
    final savingCollection = firestore.collection('savings');

    savingCollection
        .doc(id)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError(
          (error) => print("Failed to delete user: $error"),
        );
  }

  @override
  Future<void> updateSaving(Saving saving) async {
    final savingCollection = firestore.collection('savings');

    savingCollection
        .doc(saving.id)
        .update(saving.toJson())
        .then((value) => print("Saving Updated"))
        .catchError((er) => print("Failed to update Saving: $er"));
  }
}
