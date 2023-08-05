import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_app/features/auth/blocs/auth_cubit.dart';
import 'package:flutter_my_app/router/router.dart';

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
                isValidate: (value) => isPasswordValid(value),
                title: 'Passowrd',
              ),
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
                child: const Text('SignUp'),
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

class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final bool Function(String) isValidate;

  final String title;
  const CustomInputField({
    super.key,
    required this.controller,
    required this.isValidate,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
      ),
      validator: (value) {
        if (value != null) {
          final isValid = isValidate(value);
          if (isValid) {
            return null;
          }
        }
        return 'Введите валидный $title';
      },
    );
  }
}
