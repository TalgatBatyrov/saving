import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_translate/flutter_translate.dart';

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
          FilteringTextInputFormatter.deny(RegExp(r'^0+'))
        ],
        controller: _addController,
        decoration: InputDecoration(
          labelText: translate('add'),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
