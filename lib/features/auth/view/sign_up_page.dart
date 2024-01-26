import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:saving/app/routes/routes.dart';
import 'package:saving/core/extensions/validation.dart';
import 'package:saving/features/auth/bloc/auth_cubit.dart';
import 'package:saving/features/auth/bloc/verification_cubit/verification_cubit.dart';

import '../../savings/widgets/custom_input_field.dart';

@RoutePage()
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    EasyLoading.show();
    await context
        .read<AuthCubit>()
        .signUp(
          name: _nameController.text,
          email: _emailController.text,
          password: _passwordController.text,
        )
        .onError((error, stackTrace) {
      EasyLoading.showError(
        error.toString(),
      );
    }).whenComplete(() {
      EasyLoading.dismiss();
    });
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
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomInputField(
                  controller: _nameController,
                  isValidate: (value) => value.isNotEmpty,
                  title: translate('name'),
                ),
                const SizedBox(height: 16),
                CustomInputField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  isValidate: (value) => value.isValidEmail,
                  title: translate('email'),
                ),
                const SizedBox(height: 16),
                CustomInputField(
                  controller: _passwordController,
                  obscureText: true,
                  isValidate: (value) => value.isValidPassword,
                  title: translate('password'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _signUp,
                  child: Text(translate('sign_up')),
                ),
                TextButton(
                  onPressed: () => context.router.replace(const SignInRoute()),
                  child: Text(translate('snake_bar.sign_up')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
