import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repositories/savings/models/saving.dart';
import '../../toggle/toggle_cubit.dart';

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
