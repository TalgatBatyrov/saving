import 'package:flutter/material.dart';
import 'package:flutter_my_app/features/statistic/widgets/statistic_tile.dart';

import '../../../repositories/statistics/models/statistic.dart';

class StatisticsList extends StatelessWidget {
  final List<Statistic> statistics;
  const StatisticsList({
    super.key,
    required this.statistics,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(thickness: 2),
      itemCount: statistics.length,
      itemBuilder: (context, index) =>
          StatisticTile(statistic: statistics[index]),
    );
  }
}
