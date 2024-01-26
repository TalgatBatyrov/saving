import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:saving/features/auth/repository/models/auth_user/auth_user.dart';

import 'abstract_auth_repository.dart';

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

      if (user != null && user.emailVerified) {
        return getUser(user.uid);
      } else {
        throw Exception('User not verified');
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
      final userFromFirebase = response.user;

      if (userFromFirebase != null) {
        final uid = userFromFirebase.uid;

        await firestore.collection('users').doc(uid).set(
              AuthUser(
                id: uid,
                name: name,
                email: email,
              ).toJson(),
            );

        final authUser = await getUser(uid);
        return authUser;
      } else {
        throw Exception();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      } else {
        throw Exception(e.code);
      }
    } on Exception catch (_) {
      throw Exception('Error');
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
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> sendEmailVerification() async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      await user.sendEmailVerification();
    }
  }
}
