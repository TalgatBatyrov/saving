import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:saving/app/routes/routes.dart';
import 'package:saving/features/auth/bloc/auth_cubit.dart';
import 'package:saving/features/auth/bloc/verification_cubit/verification_cubit.dart';

@RoutePage()
class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  late final Timer _timer;

  @override
  void initState() {
    super.initState();

    context.read<VerificationCubit>().sendVerificationEmail();

    _timer = Timer.periodic(
      const Duration(seconds: 5),
      (_) => FirebaseAuth.instance.currentUser?.reload(),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<VerificationCubit, VerificationState>(
      listener: (context, state) {
        state.whenOrNull(
          verified: () {
            context.router.replace(const SavingsRoute());
          },
        );
      },
      child: Scaffold(
        appBar: AppBar(title: Text(translate('verify'))),
        body: Column(
          children: [
            Text(translate('email_verification')),
            Text(translate('email_yet')),
            TextButton(
              onPressed: () async {
                context.read<VerificationCubit>().sendVerificationEmail();
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
      ),
    );
  }
}
