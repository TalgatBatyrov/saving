import 'package:auto_route/auto_route.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:saving/features/saving/widgets/saving_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saving/repositories/fcm/fcm_repository.dart';
import 'package:saving/utilities/dialogs/delete_dialog.dart';
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
                body: translate('goal_achieved'),
              );
        }

        savingCubit.updateSaving(savingId: saving.id, money: money);

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
    final fcmRepos = context.read<FcmRepository>();
    final saving = widget.saving;

    return BlocProvider(
      create: (context) => ToggleVisibilityChangeGoalCubit(),
      child: GestureDetector(
        onTap: () => context.router.push(
          StatisticRoute(saving: saving),
        ),
        child: Slidable(
          key: Key(saving.id),
          startActionPane: ActionPane(
            motion: const ScrollMotion(),
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
                onPressed: (context) {
                  ShareService.shareSaving(saving);
                },
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
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            dismissible: DismissiblePane(
              closeOnCancel: true,
              confirmDismiss: () {
                return showDeleteDialog(context);
              },
              onDismissed: () {
                savingCubit.deleteSaving(widget.saving);
                fcmRepos.sendNotification(
                  title: widget.saving.goal,
                  body: translate('target_deleted'),
                );
              },
            ),
            children:  [
              SlidableAction(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
                onPressed: null,
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                label: translate('swipe_left'),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ChangeGoalNameScreen(saving: saving),
                    GoalTitle(saving: saving),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Visibility(
                          visible: saving.isCompleted,
                          child:  Text(translate('goal_achieved')),
                        ),
                        Text(
                          '${saving.percent.ceil()}%',
                          style: const TextStyle(
                            fontSize: 18,
                            shadows: [
                              Shadow(
                                color: Colors.black54,
                                offset: Offset(1, 1),
                                blurRadius: 2,
                              ),
                            ],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    LinerProgresScreen(saving: saving),
                    const SizedBox(height: 5),
                    SavingItem(title: translate('target'), value: saving.total),
                    const SizedBox(height: 5),
                    SavingItem(title: translate('accumulated'), value: saving.current),
                    const SizedBox(height: 5),
                    SavingItem(title: translate('left'), value: saving.remainder),
                    const SizedBox(height: 5),
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
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
