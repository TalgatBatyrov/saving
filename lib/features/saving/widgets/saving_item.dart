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
          ),
        ),
        Text(
          '$value',
          style: const TextStyle(
            fontSize: 18,
            shadows: [
              Shadow(
                color: Colors.black54,
                offset: Offset(1, 1),
                blurRadius: 2,
              ),
            ],
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
