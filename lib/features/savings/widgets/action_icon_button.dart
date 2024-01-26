import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:saving/core/extensions/app_extentions.dart';
import 'package:saving/core/utils/enums.dart';

class ActionIconButton extends StatelessWidget {
  final Function() onPressed;
  final ActionButton button;

  const ActionIconButton({
    super.key,
    required this.onPressed,
    required this.button,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Lottie.asset(button.asset, width: 100, height: 100),
    );
  }
}
