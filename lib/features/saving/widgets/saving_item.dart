import 'package:flutter/material.dart';

class SavingItem extends StatelessWidget {
  final String title;
  final int value;

  const SavingItem({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title),
        const SizedBox(height: 10),
        Text(
          value.toString(),
          style: const TextStyle(
            color: Colors.green,
            fontSize: 20,
          ),
        )
      ],
    );
  }
}
