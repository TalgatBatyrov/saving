part of 'profile_cubit.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState.loading() = _Loading;

  const factory ProfileState.loaded({
    required AuthUser user,
  }) = _Loaded;

  const factory ProfileState.error({
    required Exception exception,
  }) = _Error;
}
