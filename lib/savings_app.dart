import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:saving/repositories/fcm/fcm_repository.dart';
import 'package:saving/repositories/savings/abstract_savings_repository.dart';
import 'package:saving/repositories/statistics/abstract_statistics_repository.dart';
import 'package:saving/repositories/user/auth_repository.dart';
import 'package:saving/router/router.dart';
import 'package:saving/theme/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'features/auth/blocs/auth_cubit.dart';
import 'features/saving/blocs/saving_cubit.dart';
import 'features/statistic/blocs/statistic_cubit.dart';

class SavingsApp extends StatefulWidget {
  const SavingsApp({super.key});

  @override
  State<SavingsApp> createState() => _SavingsAppState();
}

class _SavingsAppState extends State<SavingsApp> {
  final _appRouter = AppRouter();
  final _authCubit = AuthCubit(GetIt.I<AuthRepository>());
  final _statisticCubit = StatisticCubit(
    GetIt.I<AbstractStatisticsRepository>(),
  );
  late final _savingCubit = SavingCubit(
    GetIt.I<AbstractSavingsRepository>(),
    FirebaseFirestore.instance,
    _statisticCubit,
    _authCubit,
  );

  @override
  void dispose() {
    super.dispose();
    _savingCubit.close();
    _statisticCubit.close();
    _authCubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => FcmRepository(FirebaseMessaging.instance),
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _savingCubit),
          BlocProvider.value(value: _statisticCubit),
          BlocProvider.value(value: _authCubit),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: darkTheme,
          routerConfig: _appRouter.config(),
        ),
      ),
    );
  }
}
