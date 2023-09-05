import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:saving/blocs/toggle/toggle_cubit.dart';
import 'package:saving/repositories/savings/models/saving.dart';
import 'package:saving/services/share_services.dart';

class StartActionPane extends StatelessWidget {
  final Saving saving;

  const StartActionPane({
    super.key,
    required this.saving,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          SlidableAction(
            onPressed: (context) {
              context.read<ToggleVisibilityChangeGoalCubit>().toggle();
            },
            backgroundColor: Colors.grey,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: translate('edit'),
          ),
          SlidableAction(
            onPressed: (_) => ShareService.shareSaving(saving),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
            backgroundColor: const Color(0xFF21B7CA),
            foregroundColor: Colors.white,
            icon: Icons.share,
            label: 'Share',
          ),
        ],
      ),
    );
  }
}
