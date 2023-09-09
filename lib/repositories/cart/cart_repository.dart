import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:saving/repositories/cart/abstract_cart_repository.dart';

import '../../models/saving/saving.dart';

class CartRepository implements AbstractCartRepository {
  final FirebaseFirestore firestore;

  final Dio dio;

  CartRepository({
    required this.dio,
    required this.firestore,
  });

  @override
  Future<List<Saving>> getCartsList({required String userId}) async {
    List<Saving> savingList = [];
    try {
      final savingsPath = 'users/$userId/carts';
      final cartCollection = firestore.collection(savingsPath);
      final response =
          await cartCollection.where('userId', isEqualTo: userId).get();

      savingList = response.docs.map((e) {
        return Saving.fromJson(e.data());
      }).toList();
    } catch (e) {
      rethrow;
    }

    return savingList;
  }

  @override
  Future<void> createCart({
    required String goal,
    required int total,
  }) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final savingsPath = 'users/$userId/carts';
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
  Future<void> deleteCart(Saving cart) async {
    final cartsPath = 'users/${cart.userId}/carts';
    final cartCollection = firestore.collection(cartsPath);

    cartCollection
        .doc(cart.id)
        .delete()
        .then((value) => print("Cart Deleted"))
        .catchError(
          (error) => print("Failed to delete user: $error"),
        );
  }

  // @override
  // Future<void> updateSaving({
  //   required String savingId,
  //   required int money,
  // }) async {
  //   final userId = FirebaseAuth.instance.currentUser!.uid;
  //   final savingsPath = 'users/$userId/savings';
  //   final savingCollection = firestore.collection(savingsPath);

  //   // current = transaction sum + current

  //   savingCollection.doc(savingId).update({'current': money});
  // }

  // @override
  // Future<void> changeSavingTitle({
  //   required String savingId,
  //   required String newTitle,
  // }) async {
  //   final userId = FirebaseAuth.instance.currentUser!.uid;
  //   final savingsPath = 'users/$userId/savings';
  //   final savingCollection = firestore.collection(savingsPath);
  //   savingCollection
  //       .doc(savingId)
  //       .update({'goal': newTitle})
  //       .then((value) => print("Saving Updated"))
  //       .catchError((er) => print("Failed to update Saving: $er"));
  // }
}
