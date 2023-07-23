import 'models/saving.dart';

abstract class AbstractSavingsRepository {
  Future<List<Saving>> getSavingsList({required String userId});
  Future<void> createSaving({required String goal, required int total});
  Future<void> deleteSaving(Saving saving);
  Future<void> updateSaving(Saving saving);
}
