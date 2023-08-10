import 'package:auto_route/auto_route.dart';
import 'package:saving/features/saving/widgets/saving_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saving/repositories/fcm/fcm_repository.dart';
import '../../../repositories/savings/models/saving.dart';
import '../../../router/router.dart';
import '../../../services/share_services.dart';
import '../../statistic/blocs/statistic_cubit.dart';
import '../../toggle/toggle_cubit.dart';
import '../blocs/saving_cubit.dart';
import 'action_icon_button.dart';
import 'change_goal_name_screen.dart';
import 'delete_saving_button.dart';
import 'goal_title.dart';
import 'liner_progres_screen.dart';
import 'money_input_field.dart';

class SavingTile extends StatefulWidget {
  final Saving saving;
  const SavingTile({
    super.key,
    required this.saving,
  });

  @override
  State<SavingTile> createState() => _SavingTileState();
}

class _SavingTileState extends State<SavingTile> {
  final _addController = TextEditingController();

  void addSaving(SavingCubit savingCubit, [bool isAdd = true]) {
    final saving = widget.saving;
    final addValue = _addController.text;
    final valueExists = addValue.isNotEmpty;

    if (valueExists) {
      final addValueInt = int.parse(addValue);

      if (addValueInt > 0) {
        final money = isAdd
            ? (saving.current + addValueInt)
            : (saving.current - addValueInt);

        if (saving.isCompleted) {
          context.read<FcmRepository>().sendNotification(
                title: widget.saving.goal,
                body: 'Цель достигнута!',
              );
        }

        savingCubit.updateSaving2(savingId: saving.id, money: money);

        context
            .read<StatisticCubit>()
            .addStatistic(
                money: isAdd ? addValueInt : -addValueInt, saving: saving)
            .onError((error, stackTrace) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.toString())),
          );
        });
      }
    }
    _addController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final savingCubit = context.read<SavingCubit>();
    final saving = widget.saving;

    return BlocProvider(
      create: (context) => ToggleVisibilityChangeGoalCubit(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shadowColor: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                ChangeGoalNameScreen(saving: saving),
                GoalTitle(saving: saving),
                const SizedBox(height: 10),
                Visibility(
                  visible: saving.isCompleted,
                  child: const Text('Цель достигнута!'),
                ),
                const SizedBox(height: 10),
                LinerProgresScreen(saving: saving),
                SavingItem(title: 'Цель', value: saving.total),
                SavingItem(title: 'Накоплено', value: saving.current),
                SavingItem(title: 'Осталось', value: saving.remainder),
                SavingItem(title: '%', value: saving.percent.toInt()),
                Row(
                  children: [
                    MoneyInputField(addController: _addController),
                    ActionIconButton(
                      icon: Icons.add,
                      onPressed: () => addSaving(savingCubit),
                    ),
                    ActionIconButton(
                      icon: Icons.remove,
                      onPressed: () => addSaving(savingCubit, false),
                    ),
                    DeleteSavingButton(saving: saving),
                    ActionIconButton(
                      icon: Icons.share,
                      onPressed: () => ShareService.shareSaving(saving),
                    ),
                    ActionIconButton(
                      icon: Icons.history,
                      onPressed: () =>
                          context.router.push(StatisticRoute(saving: saving)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
