import 'package:flutter_my_app/repositories/savings/models/saving.dart';

import 'models/statistic.dart';

abstract class AbstractStatisticsRepository {
  // Future<List<Statistic>> getStatisticsList(String savingId);
  Future<List<Statistic>> getStatisticsList(Saving saving);
  Future<void> deleteStatistic(Saving saving);
  Future<void> addStatistic({
    required Saving saving,
    required int money,
  });
}
