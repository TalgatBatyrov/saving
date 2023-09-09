import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:saving/blocs/statistic/statistic_cubit.dart';
import 'package:saving/repositories/cart/cart_repository.dart';
import 'package:saving/widgets/button_translate.dart';
import '../app_widgets/app_empty.dart';
import '../app_widgets/app_error.dart';
import '../app_widgets/app_loading.dart';
import '../models/saving/saving.dart';
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
    context.read<StatisticCubit>().getStatistics(widget.saving.id);
    super.initState();
  }

  final dio = Dio();
  final firestore = FirebaseFirestore.instance;

  late final cartRepository = CartRepository(
    dio: dio,
    firestore: firestore,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.saving.goal),
        actions: [
          const StatisticAppBarAction(),
          IconButton(
            onPressed: () {
              ButtonTranslate().onActionSheetPress(context);
            },
            icon: const Icon(Icons.translate),
          ),
          IconButton(
            onPressed: () async {
              await cartRepository.createCart(
                  goal: widget.saving.goal, total: widget.saving.total);
            },
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: BlocBuilder<StatisticCubit, StatisticState>(
        builder: (context, state) {
          return state.map(
            empty: (_) => AppEmpty(message: translate('no_statistics')),
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
