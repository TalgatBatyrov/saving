import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:replay_bloc/replay_bloc.dart';

import '../repository/user/auth_repository.dart';

part 'auth_cubit.freezed.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;
  final FirebaseAuth _firebaseAuth;

  AuthCubit(
    this._authRepository,
    this._firebaseAuth,
  ) : super(const AuthState.loading()) {
    _firebaseAuth.authStateChanges().listen(_onAuthStateChanged);
    _onAuthStateChanged(FirebaseAuth.instance.currentUser);
  }

  Future<void> _onAuthStateChanged(User? firebaseUser) async {
    if (firebaseUser == null) {
      emit(const AuthState.loggedOut());
    } else {
      emit(const AuthState.loggedIn());
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    emit(const AuthState.loading());

    await _authRepository.signIn(
      email: email,
      password: password,
    );
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(const AuthState.loading());

    await _authRepository.signUp(
      name: name,
      email: email,
      password: password,
    );
  }

  Future<void> logout() async {
    await _authRepository.signOut();
  }
}
