import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'verification_state.dart';
part 'verification_cubit.freezed.dart';

class VerificationCubit extends Cubit<VerificationState> {
  final FirebaseAuth _firebaseAuth;
  late final StreamSubscription _firebaseAuthSub;
  late final StreamSubscription _userSub;

  VerificationCubit(
    this._firebaseAuth,
  ) : super(const VerificationState.loggedOut()) {
    _firebaseAuthSub = _firebaseAuth.authStateChanges().listen(
          _onAuthStateChanged,
        );
    _userSub = _firebaseAuth.userChanges().listen(
          _onAuthStateChanged,
        );
    _onAuthStateChanged(_firebaseAuth.currentUser);
  }

  @override
  Future<void> close() {
    _firebaseAuthSub.cancel();
    _userSub.cancel();
    return super.close();
  }

  void sendVerificationEmail() {
    _firebaseAuth.currentUser?.sendEmailVerification();
  }

  void _onAuthStateChanged(User? firebaseUser) {
    if (firebaseUser == null) {
      return emit(const VerificationState.loggedOut());
    }
    if (firebaseUser.emailVerified) {
      return emit(const VerificationState.verified());
    }
    emit(const VerificationState.unverified());
  }
}
