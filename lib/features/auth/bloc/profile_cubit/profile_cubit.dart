import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:saving/features/auth/repository/models/auth_user/auth_user.dart';
import 'package:saving/features/auth/repository/user/auth_repository.dart';

part 'profile_cubit.freezed.dart';
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final AuthRepository _authRepository;
  final FirebaseAuth _firebaseAuth;

  late final StreamSubscription _firebaseAuthSub;

  ProfileCubit(this._authRepository, this._firebaseAuth)
      : super(const ProfileState.loading()) {
    _firebaseAuthSub = _firebaseAuth.authStateChanges().listen(
          _onAuthStateChanged,
        );
  }

  @override
  Future<void> close() {
    _firebaseAuthSub.cancel();
    return super.close();
  }

  void _onAuthStateChanged(User? firebaseUser) async {
    if (firebaseUser == null) {
      return emit(const ProfileState.loading());
    }

    try {
      final user = await _authRepository.getUser(
        firebaseUser.uid,
      );
      emit(ProfileState.loaded(user: user));
    } on Exception catch (ex) {
      emit(ProfileState.error(exception: ex));
    }
  }
}
