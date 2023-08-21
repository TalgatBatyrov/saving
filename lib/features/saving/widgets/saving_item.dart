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
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          width: 70,
          child: Card(
            color: Colors.green[400],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '$value',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
