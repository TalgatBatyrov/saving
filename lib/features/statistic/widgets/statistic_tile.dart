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
    DateFormat dateFormat = DateFormat("dd/MM/yyyy HH:mm");
    String date = dateFormat.format(statistic.date);

    return Row(
      children: [
        Text(date),
        const SizedBox(width: 20),
        Text('${statistic.money} com'),
      ],
    );
  }
}
