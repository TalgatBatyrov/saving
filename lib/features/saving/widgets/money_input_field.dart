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
    return Expanded(
      flex: 3,
      child: TextField(
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        controller: _addController,
        decoration: const InputDecoration(
          labelText: 'Добавить',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
