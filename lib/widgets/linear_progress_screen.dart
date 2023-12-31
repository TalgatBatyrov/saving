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
          padding: const EdgeInsets.all(20),
          width: 150,
          height: 150,
          decoration: const BoxDecoration(
              color: Color.fromARGB(190, 20, 20, 20),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(12),
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(50),
              )),
          child: Stack(
            fit: StackFit.expand,
            children: [
              CircularProgressIndicator(
                strokeWidth: 15,
                strokeCap: StrokeCap.round,
                backgroundColor:
                    saving.isCompleted ? Colors.green[100] : Colors.red[100],
                valueColor: AlwaysStoppedAnimation<Color>(
                  saving.isCompleted
                      ? Colors.green
                      : const Color.fromARGB(200, 160, 25, 15),
                ),
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
