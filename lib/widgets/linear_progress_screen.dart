import 'package:flutter/material.dart';

import '../models/saving/saving.dart';

class LinearProgressScreen extends StatelessWidget {
  const LinearProgressScreen({
    Key? key,
    required this.saving,
  }) : super(key: key);

  final Saving saving;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: saving.current / saving.total),
      duration: const Duration(seconds: 1),
      builder: (context, value, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: LinearProgressIndicator(
              backgroundColor:
                  saving.isCompleted ? Colors.green[100] : Colors.red[100],
              valueColor: AlwaysStoppedAnimation<Color>(
                saving.isCompleted ? Colors.green : Colors.red,
              ),
              minHeight: 15,
              value: value,
            ),
          ),
        );
      },
    );
  }
}
