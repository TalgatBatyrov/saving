import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:saving/blocs/auth/auth_cubit.dart';
import 'package:saving/blocs/internet_connection/internet_connection_cubit.dart';
import 'package:saving/blocs/profile_cubit/profile_cubit.dart';
import 'package:saving/blocs/saving/saving_cubit.dart';
import 'package:saving/blocs/statistic/statistic_cubit.dart';
import 'package:saving/blocs/verification_cubit/verification_cubit.dart';
import 'package:saving/repositories/fcm/fcm_repository.dart';
import 'package:saving/repositories/savings/savings_repository.dart';
import 'package:saving/repositories/statistics/statistics_repository.dart';
import 'package:saving/repositories/user/auth_repository.dart';
import 'package:saving/router/router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saving/theming/app_themes.dart';
import 'blocs/theme/theme_cubit.dart';

class SavingsApp extends StatefulWidget {
  const SavingsApp({super.key});

  @override
  State<SavingsApp> createState() => _SavingsAppState();
}

class _SavingsAppState extends State<SavingsApp> {
  final _appRouter = AppRouter();
  final _dio = Dio();
  final _firestore = FirebaseFirestore.instance;
  final _firebaseAuth = FirebaseAuth.instance;
  final _firebaserMessaging = FirebaseMessaging.instance;

  late final _statisticRepository = StatisticsRepository(_firestore);
  late final _savingRepository = SavingsRepository(
    dio: _dio,
    firestore: _firestore,
  );
  late final _authRepository = AuthRepository(_firebaseAuth, _firestore);
  late final _authCubit = AuthCubit(_authRepository, _firebaseAuth);
  late final _profileCubit = ProfileCubit(_authRepository, _firebaseAuth);

  late final _statisticCubit = StatisticCubit(_statisticRepository);
  late final _savingCubit = SavingCubit(
    _savingRepository,
    _firestore,
    _statisticCubit,
    _profileCubit,
  );
  late final _verificationCubit = VerificationCubit(
    _firebaseAuth,
  );

  @override
  void dispose() {
    super.dispose();
    _savingCubit.close();
    _statisticCubit.close();
    _authCubit.close();
    _profileCubit.close();
    _verificationCubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => FcmRepository(_firebaserMessaging)),
        RepositoryProvider.value(value: _savingRepository),
        RepositoryProvider.value(value: _authRepository),
        RepositoryProvider.value(value: _statisticRepository)
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _savingCubit),
          BlocProvider.value(value: _statisticCubit),
          BlocProvider.value(value: _authCubit),
          BlocProvider.value(value: _profileCubit),
          BlocProvider(create: (_) => ThemeCubit()),
          BlocProvider(create: (_) => InternetConnectionCubit()),
          BlocProvider.value(value: _verificationCubit),
        ],
        child: BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              themeMode: themeMode,
              theme: AppThemes.light,
              darkTheme: AppThemes.dark,
              routerConfig: _appRouter.config(),
            );
          },
        ),
      ),
    );
  }
}
