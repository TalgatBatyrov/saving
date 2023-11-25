import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MoneyInputField extends StatelessWidget {
  const MoneyInputField({
    super.key,
    required TextEditingController addController,
  }) : _addController = addController;

  final TextEditingController _addController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        FilteringTextInputFormatter.deny(RegExp(r'^0+'))
      ],
      controller: _addController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
      ),
    );
  }
}
