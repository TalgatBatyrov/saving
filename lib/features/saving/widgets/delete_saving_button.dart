import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repositories/savings/models/saving.dart';
import '../blocs/saving_cubit.dart';

class DeleteSavingButton extends StatelessWidget {
  const DeleteSavingButton({
    super.key,
    required this.saving,
  });

  final Saving saving;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: IconButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Удалить цель?'),
                content: const Text(
                  'Вы уверены, что хотите удалить цель?',
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Нет')),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      context.read<SavingCubit>().deleteSaving(saving);
                    },
                    child: const Text('Да'),
                  ),
                ],
              );
            },
          );
        },
        icon: const Icon(
          Icons.delete,
          color: Colors.red,
        ),
      ),
    );
  }
}
