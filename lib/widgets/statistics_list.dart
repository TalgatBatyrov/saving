import 'package:flutter_translate/flutter_translate.dart';
import 'package:saving/widgets/statistic_tile.dart';
import 'package:flutter/material.dart';
import '../models/saving/saving.dart';
import '../models/statistic/statistic.dart';

class StatisticsList extends StatelessWidget {
  final List<Statistic> statistics;
  final Saving saving;
  const StatisticsList({
    super.key,
    required this.statistics,
    required this.saving,
  });

  @override
  Widget build(BuildContext context) {
    final average = statistics.map((e) => e.money).reduce(
              (a, b) => a + b,
            ) /
        statistics.length;
    final dayForOver = ((saving.total - saving.current) / average).round();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          color: const Color.fromARGB(255, 27, 202, 176),
          elevation: 4,
          child: Column(
            children: [
              ListTile(
                leading: const Text('KGS'),
                title: Text(translate('average_value')),
                trailing: Text('${average.round()}'),
              ),
              ListTile(
                leading: Text(translate('days')),
                title: Text(translate('pace_yet')),
                trailing: Text('${dayForOver > 0 ? dayForOver : 0}'),
              ),
            ],
          ),
        ),
        // const SizedBox(height: 16),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2,
            ),
            // separatorBuilder: (context, index) => const Divider(thickness: 2),
            itemCount: statistics.length,
            itemBuilder: (context, index) =>
                StatisticTile(statistic: statistics[index]),
          ),
        ),
      ],
    );
  }
}
