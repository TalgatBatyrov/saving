import 'package:flutter_translate/flutter_translate.dart';
import 'package:saving/features/savings/repository/models/saving/saving.dart';
import 'package:saving/features/statistic/repository/models/statistic/statistic.dart';
import 'package:share_plus/share_plus.dart';

abstract class ShareService {
  static Future<void> shareStatistics(List<Statistic> statistics) async {
    final statisticsString =
        statistics.map((e) => '${e.date} - ${e.money} com').toList();
    await Share.share(statisticsString.join('\n'));
  }

  static Future<void> shareSaving(Saving saving) async {
    final message =
        '${translate('target')}: ${saving.goal}\n${translate('accumulated')}: ${saving.current}\n${translate('left')}: ${saving.remainder}\n %: ${saving.percent}';

    await Share.share(message);
  }
}
