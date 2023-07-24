import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_app/app_widgets/app_empty.dart';
import 'package:flutter_my_app/repositories/savings/models/saving.dart';

import '../../../app_widgets/app_error.dart';
import '../../../app_widgets/app_loading.dart';
import '../blocs/statistic_cubit.dart';
import '../widgets/statistic_app_bar_action.dart';
import '../widgets/statistics_list.dart';

@RoutePage()
class StatisticPage extends StatefulWidget {
  final Saving saving;
  const StatisticPage({super.key, required this.saving});

  @override
  State<StatisticPage> createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  @override
  void initState() {
    context.read<StatisticCubit>().getStatistics(widget.saving);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.saving.goal),
        actions: const [StatisticAppBarAction()],
      ),
      body: BlocBuilder<StatisticCubit, StatisticState>(
        builder: (context, state) {
          return state.map(
            empty: (_) => const AppEmpty(),
            loading: (_) => const AppLoading(),
            loaded: (v) =>
                StatisticsList(statistics: v.statistics, saving: widget.saving),
            error: (v) => AppError(message: v.message),
          );
        },
      ),
    );
  }
}
