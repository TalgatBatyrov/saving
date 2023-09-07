part of 'verification_cubit.dart';

@freezed
class VerificationState with _$VerificationState {
  const factory VerificationState.loggedOut() = _Loading;
  const factory VerificationState.verified() = _Verified;
  const factory VerificationState.unverified() = _Unverified;
}
