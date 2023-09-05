// ignore_for_file: use_build_context_synchronously
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:saving/blocs/saving/saving_cubit.dart';
import 'package:saving/repositories/fcm/fcm_repository.dart';
import 'package:saving/utilities/dialogs/delete_dialog.dart';
import '../repositories/savings/models/saving.dart';

class DeleteSavingButton extends StatelessWidget {
  final Saving saving;

  const DeleteSavingButton({super.key, required this.saving});

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
    final isConfirmed = await showDeleteDialog(context);

    if (isConfirmed) {
      context.router.pop();
      context.read<SavingCubit>().deleteSaving(saving);
      final fcmRepository = context.read<FcmRepository>();
      fcmRepository.sendNotification(
        title: saving.goal,
        body: translate('target_deleted'),
      );
    }
  }
}
