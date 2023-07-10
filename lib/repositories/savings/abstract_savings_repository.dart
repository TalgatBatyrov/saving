import 'models/saving.dart';

abstract class AbstractSavingsRepository {
  Future<List<Saving>> getSavingsList();
  Future<void> createSaving({required String goal, required int total});
  Future<void> deleteSaving(String id);
  Future<void> updateSaving(Saving saving);
}
