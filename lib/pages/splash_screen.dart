import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saving/blocs/auth/auth_cubit.dart';
import '../app_widgets/app_loading.dart';
import '../router/router.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final _authCubit = context.read<AuthCubit>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _authCubit.initAuthState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        state.whenOrNull(
          loggedIn: (user) {
            context.router.replace(SavingsRoute(user: user));
          },
          needVerification: () {
            context.router.replace(const VerifyEmailRoute());
          },
          loggedOut: () {
            context.router.replace(const SignInRoute());
          },
        );
      },
      child: const Scaffold(
        body: AppLoading(),
      ),
    );
  }
}
