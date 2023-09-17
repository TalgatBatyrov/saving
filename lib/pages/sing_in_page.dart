import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:saving/blocs/auth/auth_cubit.dart';
import 'package:saving/blocs/verification_cubit/verification_cubit.dart';
import 'package:saving/widgets/button_translate.dart';

import '../router/router.dart';
import '../widgets/custom_input_field.dart';

@RoutePage()
class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isEmailValid(String email) {
    final RegExp emailRegExp =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

    return emailRegExp.hasMatch(email);
  }

  bool isPasswordValid(String password) {
    return password.length >= 6;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<VerificationCubit, VerificationState>(
      listener: (context, state) async {
        state.whenOrNull(
          verified: () {
            context.router.replace(const SavingsRoute());
          },
          unverified: () {
            context.router.replace(const VerifyEmailRoute());
          },
        );
      },
      child: Form(
        key: _formKey,
        child: Scaffold(
            body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomInputField(
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                isValidate: (value) => isEmailValid(value),
                title: translate('email'),
              ),
              const SizedBox(height: 16),
              CustomInputField(
                controller: _passwordController,
                obscureText: true,
                isValidate: (value) => isPasswordValid(value),
                title: translate('password'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) return;

                  EasyLoading.show();
                  await context
                      .read<AuthCubit>()
                      .signIn(
                        email: _emailController.text,
                        password: _passwordController.text,
                      )
                      .onError((error, _) {
                    EasyLoading.showError(error.toString());
                  }).whenComplete(() {
                    EasyLoading.dismiss();
                  });
                },
                child: Text(translate('login')),
              ),
              TextButton(
                onPressed: () => context.router.replace(const SignUpRoute()),
                child: Text(translate('snake_bar.login')),
              ),
              IconButton(
                onPressed: () {
                  ButtonTranslate().onActionSheetPress(context);
                },
                icon: const Icon(Icons.translate),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
