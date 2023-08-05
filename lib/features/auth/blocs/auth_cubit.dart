import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_app/repositories/user/auth_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../repositories/user/models/auth_user.dart';

part 'auth_cubit.freezed.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _userRepository;

  AuthCubit(this._userRepository) : super(const AuthState.loading()) {
    FirebaseAuth.instance.authStateChanges().listen(_onAuthStateChanged);
    // _onAuthStateChanged(FirebaseAuth.instance.currentUser);
  }

  Future<void> _onAuthStateChanged(User? firebaseUser) async {
    print("firebaseUser: $firebaseUser");
    try {
      if (firebaseUser == null) {
        emit(const AuthState.loggedOut());
        return;
      }

      if (!firebaseUser.emailVerified) {
        print('User is not verified');
        emit(const AuthState.needVerification());
        return;
      }
      final user = await _userRepository.getUser(firebaseUser.uid);

      emit(AuthState.loggedIn(user: user));
    } catch (e) {
      emit(const AuthState.loggedOut());
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      emit(const AuthState.loading());

      final user = await _userRepository.signIn(
        email: email,
        password: password,
      );

      emit(AuthState.loggedIn(user: user));
    } on Exception catch (e) {
      emit(AuthState.error(e));
    }
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      emit(const AuthState.loading());

      await _userRepository.signUp(
        name: name,
        email: email,
        password: password,
      );
    } on Exception catch (e) {
      emit(AuthState.error(e));
    }
  }

  Future<void> logout() async {
    await _userRepository.signOut();
  }

  Future<void> initAuthState() async {
    try {
      emit(const AuthState.loading());
      final firebaseUser = FirebaseAuth.instance.currentUser;

      if (firebaseUser == null) {
        return emit(const AuthState.loggedOut());
      }

      final user = await _userRepository.getUser(firebaseUser.uid);
      emit(AuthState.loggedIn(user: user));
    } catch (e) {
      emit(const AuthState.loggedOut());
    }
  }
}