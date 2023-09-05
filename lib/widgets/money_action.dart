import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:saving/blocs/saving/saving_cubit.dart';
import 'package:saving/repositories/fcm/fcm_repository.dart';
import 'package:saving/models/saving/saving.dart';
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

        savingCubit.updateSaving(
          savingId: saving.id,
          money: money <= 0 ? 0 : money,
          moneyForStatistic: isAdd ? addValueInt : -addValueInt,
        );
      }
    }
    _addController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final savingCubit = context.read<SavingCubit>();

    return Row(
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
    );
  }
}
