part of 'cart_cubit.dart';

@freezed
class CartState with _$CartState {
  const CartState._();

  const factory CartState.loading() = _Loading;

  const factory CartState.loaded({required List<Saving> savings}) = _Loaded;

  const factory CartState.error(Exception message) = _Error;
}
