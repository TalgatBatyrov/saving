import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

import '../../../repositories/statistics/models/statistic.dart';
import '../blocs/statistic_cubit.dart';

class StatisticAppBarAction extends StatelessWidget {
  const StatisticAppBarAction({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatisticCubit, StatisticState>(
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () => const SizedBox.shrink(),
          loaded: (statistics) {
            return IconButton(
              onPressed: () {
                ShareService.shareStatistics(statistics);
              },
              icon: const Icon(Icons.share),
            );
          },
        );
      },
    );
  }
}

/// TODO: extract to separate file in services folder
abstract class ShareService {
  static Future<void> shareStatistics(List<Statistic> statistic) async {
    final statisticString =
        statistic.map((e) => '${e.date} - ${e.money} com').toList();
    await Share.share(statisticString.join('\n'));
  }
}
