import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saving/features/auth/blocs/auth_cubit.dart';
import 'package:saving/router/router.dart';

@RoutePage()
class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify')),
      body: Column(
        children: [
          const Text(
              'We\'ve sent you an email verification. Please open it to verify your account.'),
          const Text(
              'If you haven\'t received a verification email yet, press the button below'),
          TextButton(
            onPressed: () async {
              context.read<AuthCubit>().sendEmailVerification();
            },
            child: const Text('Send email verification'),
          ),
          TextButton(
            onPressed: () async {
              context.read<AuthCubit>().logout();
              context.router.replace(const SignInRoute());
            },
            child: const Text('Restart'),
          ),
        ],
      ),
    );
  }
}
