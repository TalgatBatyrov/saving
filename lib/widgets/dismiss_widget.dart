import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:saving/blocs/saving/saving_cubit.dart';
import 'package:saving/models/saving/saving.dart';
import 'package:saving/repositories/fcm/fcm_repository.dart';
import 'package:saving/utilities/dialogs/delete_dialog.dart';

class DismissWidget extends StatelessWidget {
  final Saving saving;

  const DismissWidget({
    super.key,
    required this.saving,
  });

  @override
  Widget build(BuildContext context) {
    final savingCubit = context.read<SavingCubit>();
    final fcmRepos = context.read<FcmRepository>();
    return DismissiblePane(
      closeOnCancel: true,
      confirmDismiss: () {
        return showDeleteDialog(context);
      },
      onDismissed: () async {
        savingCubit.deleteSaving(saving);
        fcmRepos.sendNotification(
          title: saving.goal,
          body: translate('target_deleted'),
        );
      },
    );
  }
}
