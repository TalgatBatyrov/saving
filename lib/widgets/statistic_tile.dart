import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../repositories/statistics/models/statistic.dart';

class StatisticTile extends StatelessWidget {
  const StatisticTile({
    super.key,
    required this.statistic,
  });

  final Statistic statistic;

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat.yMMMd('en_US');
    String date = dateFormat.format(statistic.date);

    return Card(
      color: statistic.money > 0 ? Colors.green : Colors.red,
      elevation: 4,
      child: ListTile(
        leading: Text(
          '${statistic.money} KGS',
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Text(date),
      ),
    );
  }
}
