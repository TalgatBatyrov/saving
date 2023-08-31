import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final bool Function(String) isValidate;
  final bool obscureText;

  final String title;
  const CustomInputField({
    super.key,
    required this.controller,
    required this.isValidate,
    required this.title,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(labelText: title),
      validator: (value) {
        if (value != null) {
          final isValid = isValidate(value);
          if (isValid) {
            return null;
          }
        }
        return '${translate('input_field')} $title';
      },
    );
  }
}
