part of 'saving_cubit.dart';

@freezed
class SavingState with _$SavingState {
  const factory SavingState.loading() = _Loading;
  const factory SavingState.loaded({required List<Saving> savings}) = _Loaded;
  const factory SavingState.error(String message) = _Error;
  const factory SavingState.empty() = _Empty;
}
