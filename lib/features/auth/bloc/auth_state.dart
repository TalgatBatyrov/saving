part of 'auth_cubit.dart';

@freezed
class AuthState with _$AuthState {
  const AuthState._();

  const factory AuthState.loading() = _Loading;
  const factory AuthState.loggedIn() = _LoggedIn;
  const factory AuthState.loggedOut() = _LoggedOut;
}
