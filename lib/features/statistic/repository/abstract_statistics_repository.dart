import 'package:saving/features/savings/repository/models/saving/saving.dart';
import 'package:saving/features/statistic/repository/models/statistic/statistic.dart';

abstract class AbstractStatisticsRepository {
  Future<List<Statistic>> getStatisticsList(String savingId);
  Future<void> deleteStatistics(Saving saving);
  Future<void> editStatistic(Statistic statistic);
  Future<void> deleteStatisticById(Statistic statistic);
  Future<void> addStatistic({required String savingId, required int money});
}
