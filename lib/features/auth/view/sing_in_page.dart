import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../router/router.dart';
import '../blocs/auth_cubit.dart';
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
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) async {
        state.whenOrNull(
          loggedIn: (user) {
            context.router.replace(SavingsRoute(user: user));
          },
          error: (message) {
            _showAuthErrorDialog(context, message.toString());
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
                controller: _emailController,
                isValidate: (value) => isEmailValid(value),
                title: 'Email',
              ),
              CustomInputField(
                controller: _passwordController,
                obscureText: true,
                isValidate: (value) => isPasswordValid(value),
                title: 'Passowrd',
              ),
              const SizedBox(height: 16),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    orElse: () {
                      return ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await context.read<AuthCubit>().signIn(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                );
                          }
                        },
                        child: const Text('Login'),
                      );
                    },
                  );
                },
              ),
              TextButton(
                onPressed: () => context.router.replace(const SignUpRoute()),
                child: const Text('You don\'t have an account? Sign up'),
              ),
            ],
          ),
        )),
      ),
    );
  }

  Future<dynamic> _showAuthErrorDialog(BuildContext context, String message) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => context.router.pop(),
            child: const Text('Ok'),
          )
        ],
      ),
    );
  }
}
