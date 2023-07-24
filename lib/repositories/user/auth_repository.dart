import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_my_app/repositories/user/abstract_auth_repository.dart';

import 'models/auth_user.dart';

class AuthRepository implements AbstractAuthRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore firestore;

  AuthRepository(this._firebaseAuth, this.firestore);

  @override
  Future<AuthUser> signIn({
    required email,
    required password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = _firebaseAuth.currentUser;

      if (user != null) {
        return getUser(user.uid);
      } else {
        throw Exception();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
        // throw UserNotFoundAuthException();
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
        // throw WrongPasswordAuthException();
      } else {
        throw Exception(e.code);
        // throw GenericAuthException();
      }
    } catch (_) {
      throw Exception('Error');
      // throw GenericAuthException();
    }
  }

  @override
  Future<AuthUser> signUp({
    required name,
    required email,
    required password,
  }) async {
    try {
      final response = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (response.user != null) {
        firestore.collection('users').doc(response.user!.uid).set(
              AuthUser(
                id: response.user!.uid,
                name: name,
                email: email,
              ).toJson(),
            );
      }
      final user = _firebaseAuth.currentUser;

      if (user != null) {
        final authUser = await getUser(user.uid);
        return authUser;
      } else {
        throw Exception();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
        // throw WeakPasswordAuthException();
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
        // throw EmailAlreadyInUseAuthException();
      } else {
        throw Exception(e.code);
        // throw GenericAuthException();
      }
    } on Exception catch (_) {
      throw Exception('Error');
      // throw GenericAuthException();
    }
  }

  @override
  Future<AuthUser> getUser(String id) async {
    final response = await firestore.collection('users').doc(id).get();
    if (response.data() == null || !response.exists) {
      throw Exception('User not found');
    }
    final user = AuthUser.fromJson(response.data()!);

    return user;
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut().whenComplete(() => print('Signed out'));
  }
}
