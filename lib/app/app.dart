import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:saving/app/routes/routes.dart';
import 'package:saving/core/services/fcm/fcm_repository.dart';
import 'package:saving/features/auth/bloc/auth_cubit.dart';
import 'package:saving/features/auth/bloc/profile_cubit/profile_cubit.dart';
import 'package:saving/features/auth/bloc/verification_cubit/verification_cubit.dart';
import 'package:saving/features/auth/repository/user/auth_repository.dart';
import 'package:saving/features/blocs/currency/currency_cubit.dart';
import 'package:saving/features/blocs/internet_connection/internet_connection_cubit.dart';
import 'package:saving/features/savings/bloc/saving_cubit.dart';
import 'package:saving/features/savings/repository/savings_repository.dart';
import 'package:saving/features/statistic/bloc/statistic/statistic_cubit.dart';
import 'package:saving/features/statistic/bloc/statistic_changes/statistic_changes_cubit.dart';
import 'package:saving/features/statistic/repository/statistics_repository.dart';
import 'package:saving/ui/themes/themes.dart';

import '../features/blocs/theme/theme_cubit.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _appRoutes = AppRoutes();
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
  late final _statisticChandedCubit = StatisticChangesCubit();

  late final _statisticCubit = StatisticCubit(_statisticRepository);
  late final _savingCubit = SavingCubit(
    _savingRepository,
    _firestore,
    _statisticCubit,
    _profileCubit,
    _statisticChandedCubit,
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
    _statisticChandedCubit.close();
  }

  @override
  Widget build(BuildContext context) {
    EasyLoading.instance.userInteractions = false;

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
          BlocProvider.value(value: _statisticChandedCubit),
          BlocProvider(create: (context) => CurrencyCubit()),
        ],
        child: BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              themeMode: themeMode,
              theme: Themes.light,
              darkTheme: Themes.dark,
              routerConfig: _appRoutes.config(),
              builder: EasyLoading.init(),
            );
          },
        ),
      ),
    );
  }
}
