import 'package:auto_route/auto_route.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:saving/widgets/dismiss_widget.dart';
import 'package:saving/widgets/money_action.dart';
import 'package:saving/widgets/progress_in_percent.dart';
import 'package:saving/widgets/saving_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saving/widgets/start_action_pane.dart';
import '../models/saving/saving.dart';
import '../router/router.dart';
import '../blocs/toggle/toggle_cubit.dart';
import 'change_goal_name_screen.dart';
import 'liner_progress_screen.dart';

class SavingTile extends StatelessWidget {
  final Saving saving;
  const SavingTile({super.key, required this.saving});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ToggleVisibilityChangeGoalCubit(),
      child: GestureDetector(
        onTap: () => context.router.push(StatisticRoute(saving: saving)),
        child: Slidable(
          key: Key(saving.id),
          startActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [StartActionPane(saving: saving)],
          ),
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            dismissible: DismissWidget(saving: saving),
            children: [
              SlidableAction(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
                onPressed: null,
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                label: translate('snake_bar.swipe_left'),
              ),
            ],
          ),
          child: Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ChangeGoalNameScreen(saving: saving),
                  const SizedBox(height: 5),
                  ProgressInPercent(saving: saving),
                  LinerProgressScreen(saving: saving),
                  const SizedBox(height: 5),
                  SavingItem(title: translate('target'), value: saving.total),
                  const SizedBox(height: 5),
                  SavingItem(
                      title: translate('accumulated'), value: saving.current),
                  const SizedBox(height: 5),
                  SavingItem(title: translate('left'), value: saving.remainder),
                  const SizedBox(height: 5),
                  MoneyAction(saving: saving)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
