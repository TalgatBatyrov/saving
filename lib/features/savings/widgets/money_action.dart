import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:saving/core/services/fcm/fcm_repository.dart';
import 'package:saving/core/utils/enums.dart';
import 'package:saving/features/savings/bloc/saving_cubit.dart';
import 'package:saving/features/savings/repository/models/saving/saving.dart';
import 'package:saving/features/savings/widgets/action_icon_button.dart';
import 'package:saving/features/savings/widgets/money_input_field.dart';

class MoneyAction extends StatefulWidget {
  final Saving saving;
  const MoneyAction({super.key, required this.saving});

  @override
  State<MoneyAction> createState() => _MoneyActionState();
}

class _MoneyActionState extends State<MoneyAction> {
  final _addController = TextEditingController();

  void addSaving(SavingCubit savingCubit, [bool isAdd = true]) {
    final saving = widget.saving;
    final addValue = _addController.text;
    final valueExists = addValue.isNotEmpty;

    if (saving.isCompleted) {
      context.read<FcmRepository>().sendNotification(
            title: widget.saving.goal,
            body: translate('goal_achieved'),
          );
    }

    if (valueExists) {
      final addValueInt = int.parse(addValue);

      if (addValueInt > 0) {
        savingCubit.updateSaving(
          savingId: saving.id,
          moneyForStatistic: isAdd ? addValueInt : -addValueInt,
        );
      }
    }
    _addController.clear();
    Navigator.pop(context);

    context.popRoute();
  }

  @override
  Widget build(BuildContext context) {
    final savingCubit = context.read<SavingCubit>();

    return ActionIconButton(
      button: ActionButton.add,
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              color: const Color.fromARGB(190, 20, 20, 20),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  MoneyInputField(addController: _addController),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () => addSaving(savingCubit),
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.all(10),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () => addSaving(savingCubit, false),
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.all(10),
                        ),
                        child: const Icon(
                          Icons.remove,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
