import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../repositories/statistics/models/statistic.dart';

class StatisticTile extends StatelessWidget {
  const StatisticTile({
    super.key,
    required this.statistic,
  });

  final Statistic statistic;

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat.yMMMMd('en_US');
    String date = dateFormat.format(statistic.date);

    return ListTile(
      leading: const Text('KGS'),
      title: Text(date),
      trailing: Text('${statistic.money}'),
    );
  }
}
