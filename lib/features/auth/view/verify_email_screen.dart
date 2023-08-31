import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:saving/features/auth/blocs/auth_cubit.dart';
import 'package:saving/router/router.dart';

@RoutePage()
class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(translate('verify'))),
      body: Column(
        children: [
          Text(translate('email_verification')),
          Text(translate('email_yet')),
          TextButton(
            onPressed: () async {
              context.read<AuthCubit>().sendEmailVerification();
            },
            child: Text(translate('send')),
          ),
          TextButton(
            onPressed: () async {
              context.read<AuthCubit>().logout();
              context.router.replace(const SignInRoute());
            },
            child: Text(translate('restart')),
          ),
        ],
      ),
    );
  }
}
