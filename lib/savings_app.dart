import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_app/features/saving/bloc/statistic/statistic_cubit.dart';
import 'package:flutter_my_app/features/saving/bloc/saving_cubit.dart';
import 'package:flutter_my_app/repositories/savings/abstract_savings_repository.dart';
import 'package:flutter_my_app/router/router.dart';
import 'package:flutter_my_app/theme/theme.dart';
import 'package:get_it/get_it.dart';

class SavingsApp extends StatefulWidget {
  const SavingsApp({super.key});

  @override
  State<SavingsApp> createState() => _SavingsAppState();
}

class _SavingsAppState extends State<SavingsApp> {
  final appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => SavingCubit(
            GetIt.I<AbstractSavingsRepository>(),
            FirebaseFirestore.instance,
          ),
        ),
        BlocProvider(create: (_) => StatisticCubit(FirebaseFirestore.instance)),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: darkTheme,
        routerConfig: appRouter.config(),
      ),
    );
  }
}
