import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app_widgets/app_loading.dart';
import '../../../router/router.dart';
import '../blocs/auth_cubit.dart';

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
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
              ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
              ),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    loading: () => const AppLoading(),
                    orElse: () {
                      return ElevatedButton(
                        onPressed: () async {
                          await context.read<AuthCubit>().signUp(
                                name: _nameController.text,
                                email: _emailController.text,
                                password: _passwordController.text,
                              );
                        },
                        child: const Text('Sign up'),
                      );
                    },
                  );
                },
              ),
              TextButton(
                onPressed: () => context.router.replace(const SignInRoute()),
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
