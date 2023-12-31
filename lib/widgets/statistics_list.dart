import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:saving/blocs/currency/currency_cubit.dart';
import 'package:saving/widgets/statistic_tile.dart';

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
    int dayForOver = 0;
    if (average != 0) {
      dayForOver = ((saving.total - saving.current) / average).round();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          color: const Color.fromARGB(105, 20, 20, 20),
          elevation: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                textColor: Colors.white,
                title: Text(translate('average_value'),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
                trailing: BlocBuilder<CurrencyCubit, Currency>(
                  builder: (context, state) {
                    return Text('${average.round()} ${state.name}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ));
                  },
                ),
              ),
              average != 0
                  ? ListTile(
                      textColor: Colors.white,
                      title: Text(translate('pace_yet'),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )),
                      trailing: Text(
                          '${dayForOver > 0 ? dayForOver : 0} ${translate('days')}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: statistics.length,
            itemBuilder: (context, index) =>
                StatisticTile(statistic: statistics[index]),
          ),
        ),
      ],
    );
  }
}
