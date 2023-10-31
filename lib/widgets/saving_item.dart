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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
        Text(
          '$value',
          style: const TextStyle(
            fontSize: 18,
            color: Color(0xFF483D6B),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
