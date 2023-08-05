import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify'),
      ),
      body: Column(
        children: [
          const Text(
              'We\'ve sent you an email verification. Please open it to verify your account.'),
          const Text(
              'If you haven\'t received a verification email yet, press the button below'),
          TextButton(
            onPressed: () async {
              // AuthService.firebase().sendEmailVerification();
            },
            child: const Text('Send email verification'),
          ),
          TextButton(
            onPressed: () async {
              // await AuthService.firebase().logOut();
              // // ignore: use_build_context_synchronously
              // Navigator.of(context).pushNamedAndRemoveUntil(
              //   registerRoute,
              //   (route) => false,
              // );
            },
            child: const Text('Restart'),
          ),
        ],
      ),
    );
  }
}
