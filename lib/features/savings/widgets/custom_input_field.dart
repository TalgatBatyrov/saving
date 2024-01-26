import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final bool Function(String) isValidate;
  final bool obscureText;
  final TextInputType? keyboardType;

  final String title;
  const CustomInputField({
    super.key,
    required this.controller,
    required this.isValidate,
    required this.title,
    this.obscureText = false,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: title,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (value) {
        if (value != null) {
          final isValid = isValidate(value);
          if (isValid) {
            return null;
          }
        }
        return '${translate('snake_bar.input_field')} $title';
      },
    );
  }
}
