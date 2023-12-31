import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:saving/blocs/saving/saving_cubit.dart';
import 'package:saving/models/saving/saving.dart';
import 'package:saving/repositories/fcm/fcm_repository.dart';
import 'package:saving/utilities/enums/app_enums.dart';
import 'package:saving/widgets/action_icon_button.dart';
import 'package:saving/widgets/money_input_field.dart';

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
                  Expanded(
                    child: MoneyInputField(addController: _addController),
                  ),
                  Row(
                    children: [
                      ActionIconButton(
                        button: ActionButton.add,
                        onPressed: () => addSaving(savingCubit, true),
                      ),
                      ActionIconButton(
                        button: ActionButton.remove,
                        onPressed: () => addSaving(savingCubit, false),
                      ),
                      OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(translate('cancel'),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
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
