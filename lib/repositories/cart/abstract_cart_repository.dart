import '../../models/saving/saving.dart';

abstract class AbstractCartRepository {
  Future<List<Saving>> getCartsList({required String userId});
  Future<void> createCart({required String goal, required int total});
  Future<void> deleteCart(Saving cart);
  // Future<void> updateSaving({
  //   required String savingId,
  //   required int money,
  // });
  // Future<void> changeSavingTitle({
  //   required String savingId,
  //   required String newTitle,
  // });
}
