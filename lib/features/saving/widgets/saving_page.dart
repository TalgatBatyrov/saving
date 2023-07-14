import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_app/features/saving/bloc/statistic/statistic_cubit.dart';
import 'package:flutter_my_app/features/saving/bloc/statistic/statistic_state.dart';
import 'package:flutter_my_app/repositories/savings/models/saving.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

@RoutePage()
class SavingPage extends StatefulWidget {
  final Saving saving;
  const SavingPage({
    super.key,
    required this.saving,
  });

  @override
  State<SavingPage> createState() => _SavingPageState();
}

class _SavingPageState extends State<SavingPage> {
  @override
  void initState() {
    context.read<StatisticCubit>().load(widget.saving.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          BlocBuilder<StatisticCubit, StatisticState>(
            builder: (context, state) {
              if (state is StatisticLoaded) {
                return IconButton(
                  onPressed: () {
                    final statistic = state.statistics
                        .map((e) => '${e.date} - ${e.money} com')
                        .toList();

                    Share.share(statistic.join('\n'));
                  },
                  icon: const Icon(Icons.share),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<StatisticCubit, StatisticState>(
              builder: (context, state) {
                if (state is StatisticLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is StatisticLoaded) {
                  return Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: state.statistics.map(
                          (e) {
                            DateFormat dateFormat =
                                DateFormat("dd/MM/yyyy HH:mm");
                            String date = dateFormat.format(e.date);

                            return Row(
                              children: [
                                Text(date),
                                const SizedBox(width: 20),
                                Text('${e.money} com'),
                              ],
                            );
                          },
                        ).toList(),
                      ),
                      Expanded(
                        child: Text(
                          'Среднестатический в день ${state.averagePrice}',
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Всего накоплено: ${widget.saving.current}',
                        ),
                      ),
                      if (widget.saving.total > widget.saving.current)
                        Expanded(
                          child: Text(
                            'Такими темпами еще ${((widget.saving.total - widget.saving.current) / state.averagePrice).round()} день (дней)',
                          ),
                        ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
