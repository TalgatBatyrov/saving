import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../services/share_services.dart';
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
