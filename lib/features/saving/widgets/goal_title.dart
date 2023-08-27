import 'package:flutter/material.dart';
import '../../../repositories/savings/models/saving.dart';

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
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
