import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:saving/blocs/auth/auth_cubit.dart';
import 'package:saving/utilities/dialogs/error_dialog.dart';
import 'package:saving/utilities/extensions/validation.dart';
import '../app_widgets/app_loading.dart';
import '../router/router.dart';
import '../widgets/custom_input_field.dart';

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

    await context.read<AuthCubit>().signUp(
          name: _nameController.text,
          email: _emailController.text,
          password: _passwordController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) async {
        state.whenOrNull(
          needVerification: () =>
              context.router.replace(const VerifyEmailRoute()),
          loggedIn: (user) {
            context.router.replace(SavingsRoute(user: user));
          },
          error: (message) {
            showErrorDialog(context, message.toString());
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
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: translate('name'),
                  ),
                ),
                CustomInputField(
                  controller: _emailController,
                  isValidate: (value) => value.isValidEmail,
                  title: translate('email'),
                ),
                CustomInputField(
                  controller: _passwordController,
                  obscureText: true,
                  isValidate: (value) => value.isValidPassword,
                  title: translate('password'),
                ),
                const SizedBox(height: 16),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      loading: () => const AppLoading(),
                      orElse: () {
                        return ElevatedButton(
                          onPressed: _signUp,
                          child: Text(translate('sign_up')),
                        );
                      },
                    );
                  },
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
