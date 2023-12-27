import 'package:flutter/material.dart';
import 'package:saving/widgets/progress_in_percent.dart';

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
          padding: const EdgeInsets.all(16),
          width: 150,
          height: 150,
          decoration: const BoxDecoration(
            color: Colors.black38,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            fit: StackFit.expand,
            children: [
              CircularProgressIndicator(
                strokeWidth: 10,
                backgroundColor:
                    saving.isCompleted ? Colors.green[100] : Colors.red[100],
                valueColor: AlwaysStoppedAnimation<Color>(
                  saving.isCompleted ? Colors.green : Colors.red,
                ),
                // minHeight: 15,
                value: value,
              ),
              ProgressInPercent(saving: saving),
            ],
          ),
        );
      },
    );
  }
}
