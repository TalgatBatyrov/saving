import 'package:saving/repositories/savings/models/saving.dart';
import 'package:share_plus/share_plus.dart';

import '../repositories/statistics/models/statistic.dart';

abstract class ShareService {
  static Future<void> shareStatistics(List<Statistic> statistics) async {
    final statisticsString =
        statistics.map((e) => '${e.date} - ${e.money} com').toList();
    await Share.share(statisticsString.join('\n'));
  }

  static Future<void> shareSaving(Saving saving) async {
    final message =
        'Цель: ${saving.goal}\nНакоплено: ${saving.current}\nОсталось: ${saving.remainder}\nВ %: ${saving.percent}';

    await Share.share(message);
  }
}
