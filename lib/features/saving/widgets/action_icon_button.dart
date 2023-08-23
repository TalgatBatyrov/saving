import 'package:flutter/material.dart';

class ActionIconButton extends StatelessWidget {
  final Function() onPressed;
  final IconData icon;

  const ActionIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.green),
      ),
    );
  }
}
