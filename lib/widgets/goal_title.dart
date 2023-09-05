import 'package:flutter/material.dart';
import '../models/saving/saving.dart';

class GoalTitle extends StatelessWidget {
  const GoalTitle({
    super.key,
    required this.saving,
  });

  final Saving saving;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        saving.goal,
        style: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
