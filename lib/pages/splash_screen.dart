import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saving/blocs/verification_cubit/verification_cubit.dart';
import '../app_widgets/app_loading.dart';
import '../router/router.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final _verificationCubit = context.read<VerificationCubit>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _verificationCubit.state.whenOrNull(
        loggedOut: () {
          context.router.replace(const SignInRoute());
        },
        unverified: () {
          context.router.replace(const VerifyEmailRoute());
        },
        verified: () {
          context.router.replace(const SavingsRoute());
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AppLoading(),
    );
  }
}
