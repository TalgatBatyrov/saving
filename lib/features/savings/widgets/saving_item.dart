import 'package:flutter/material.dart';

class SavingItem extends StatelessWidget {
  final String title;
  final int value;

  const SavingItem({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Text(
            '$value',
            style: const TextStyle(
              fontSize: 20,
              color: Color(0xFF483D6B),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
