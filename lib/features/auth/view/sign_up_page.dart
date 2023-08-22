import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../app_widgets/app_loading.dart';
import '../../../router/router.dart';
import '../blocs/auth_cubit.dart';
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

  bool isEmailValid(String email) {
    final RegExp emailRegExp =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

    return emailRegExp.hasMatch(email);
  }

  bool isPasswordValid(String password) {
    return password.length >= 6;
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
            _showAuthErrorDialog(context, message.toString());
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
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                ),
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
                      loading: () => const AppLoading(),
                      orElse: () {
                        return ElevatedButton(
                          onPressed: _signUp,
                          child: const Text('Sign up'),
                        );
                      },
                    );
                  },
                ),
                TextButton(
                  onPressed: () => context.router.replace(const SignInRoute()),
                  child: const Text('You have an account? Sign in'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
