import 'package:flutter/material.dart';

class AppEmpty extends StatelessWidget {
  final String message;
  const AppEmpty({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.red,
        ),
      ),
    );
  }
}
