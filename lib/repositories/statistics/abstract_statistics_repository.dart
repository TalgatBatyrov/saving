import '../../models/saving/saving.dart';
import '../../models/statistic/statistic.dart';

abstract class AbstractStatisticsRepository {
  Future<List<Statistic>> getStatisticsList(Saving saving);
  Future<void> deleteStatistic(Saving saving);
  Future<void> addStatistic({
    required String savingId,
    required int money,
  });
}
