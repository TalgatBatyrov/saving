// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
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
        onPressed: () async => await _onDeleteSaving(context),
        icon: const Icon(
          Icons.delete,
          color: Colors.red,
        ),
      ),
    );
  }

  Future<void> _onDeleteSaving(BuildContext context) async {
    final isConfirmed = await _showDeleteDialog(context);

    if (isConfirmed == true) {
      context.router.pop();
      context.read<SavingCubit>().deleteSaving(saving);
    }
  }
}

Future<bool?> _showDeleteDialog(BuildContext context) {
  return showDialog<bool>(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Удалить?'),
        content: const Text('Вы уверены, что хотите удалить?'),
        actions: [
          TextButton(
            onPressed: () {
              context.router.pop(false);
            },
            child: const Text('Нет'),
          ),
          TextButton(
            onPressed: () {
              context.router.pop(true);
            },
            child: const Text('Да'),
          ),
        ],
      );
    },
  );
}
