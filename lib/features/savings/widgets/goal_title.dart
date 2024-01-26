import 'package:flutter/material.dart';
import 'package:saving/features/savings/repository/models/saving/saving.dart';

class GoalTitle extends StatelessWidget {
  const GoalTitle({
    super.key,
    required this.saving,
  });

  final Saving saving;

  @override
  Widget build(BuildContext context) {
    return Text(
      saving.goal,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
