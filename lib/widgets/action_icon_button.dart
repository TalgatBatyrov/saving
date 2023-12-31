import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:saving/utilities/enums/app_enums.dart';
import 'package:saving/utilities/extensions/app_extentions.dart';

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
