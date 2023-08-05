part of 'auth_cubit.dart';

@freezed
class AuthState with _$AuthState {
  const AuthState._();

  const factory AuthState.loading() = _Loading;

  const factory AuthState.loggedIn({required AuthUser user}) = _LoggedIn;

  const factory AuthState.loggedOut() = _LoggedOut;

  const factory AuthState.error(Exception message) = _Error;

  const factory AuthState.needVerification() = _NeedVerification;
}
