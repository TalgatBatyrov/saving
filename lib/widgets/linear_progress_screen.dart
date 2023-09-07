import 'package:flutter/material.dart';
import '../models/saving/saving.dart';

class LinearProgressScreen extends StatelessWidget {
  const LinearProgressScreen({
    super.key,
    required this.saving,
  });

  final Saving saving;

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(
        saving.isCompleted ? Colors.green : Colors.red,
      ),
      minHeight: 15,
      value: saving.current / saving.total,
    );
  }
}