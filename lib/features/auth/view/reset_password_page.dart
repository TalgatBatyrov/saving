import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:saving/core/extensions/validation.dart';

@RoutePage()
class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  TextEditingController emailTextInputController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailTextInputController.dispose();

    super.dispose();
  }

  Future<void> resetPassword() async {
    final scaffoldMassager = ScaffoldMessenger.of(context);

    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailTextInputController.text.trim(),
      );
    } on FirebaseAuthException {
      const snackBar = SnackBar(
        content: Text('Произошла ошибка. Попробуйте позже'),
        backgroundColor: Colors.red,
      );

      scaffoldMassager.showSnackBar(snackBar);
      return;
    }

    const snackBar = SnackBar(
      content: Text('Сброс пароля осуществен. Проверьте почту'),
      backgroundColor: Colors.green,
    );

    scaffoldMassager.showSnackBar(snackBar).closed.then((_) {
      context.router.pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Reset password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (!value!.isValidEmail) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                controller: emailTextInputController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Email',
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: resetPassword,
                child: const Center(child: Text('Reset password')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
