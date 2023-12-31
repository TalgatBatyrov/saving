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
    return Visibility(
      replacement: Center(
        child: Text(
          '${saving.percent.ceil()}%',
          style: const TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      visible: saving.isCompleted,
      child: Center(
        child: Text(translate('goal_achieved'),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
      ),
    );
  }
}
