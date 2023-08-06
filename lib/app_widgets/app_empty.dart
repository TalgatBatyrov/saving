import 'package:flutter/material.dart';

class AppEmpty extends StatelessWidget {
  const AppEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Empty',
        style: TextStyle(
          fontSize: 20,
          color: Colors.red,
        ),
      ),
    );
  }
}
