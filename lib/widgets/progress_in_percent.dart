import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:saving/models/saving/saving.dart';

class ProgressInPercent extends StatelessWidget {
  final Saving saving;

  const ProgressInPercent({
    super.key,
    required this.saving,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Visibility(
          visible: saving.isCompleted,
          child: Text(translate('goal_achieved')),
        ),
        Text(
          '${saving.percent.ceil()}%',
          style: const TextStyle(
            fontSize: 18,
            shadows: [
              Shadow(
                color: Colors.black54,
                offset: Offset(1, 1),
                blurRadius: 2,
              ),
            ],
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
