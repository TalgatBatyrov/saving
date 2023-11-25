import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:saving/blocs/saving/saving_cubit.dart';
import 'package:saving/models/saving/saving.dart';
import 'package:saving/repositories/fcm/fcm_repository.dart';
import 'package:saving/router/router.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    final savingCubit = context.read<SavingCubit>();

    return Row(
      children: [
        const Spacer(),
        ActionIconButton(
          button: ActionButton.add,
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [Colors.blue, Colors.green],
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                              child: MoneyInputField(
                                  addController: _addController)),
                          ActionIconButton(
                            button: ActionButton.add,
                            onPressed: () => addSaving(savingCubit, false),
                          ),
                          ActionIconButton(
                            button: ActionButton.remove,
                            onPressed: () => addSaving(savingCubit, false),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(translate('cancel')),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
        IconButton(
          onPressed: () =>
              context.router.push(StatisticRoute(saving: widget.saving)),
          icon: const Icon(Icons.bar_chart),
        ),
        // GestureDetector(
        //   onTap: () async {
        //     showDialog<bool>(
        //       context: context,
        //       builder: (context) {
        //         return AlertDialog(
        //           insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        //           iconPadding: const EdgeInsets.only(top: 6, right: 12),
        //           icon: Align(
        //             alignment: Alignment.topRight,
        //             child: IconButton(
        //               onPressed: () => Navigator.pop(context),
        //               icon: const Icon(Icons.close),
        //             ),
        //           ),
        //           contentPadding: const EdgeInsets.all(16),
        //           content: OrderPhotoModal(savingId: widget.saving.id),
        //         );
        //       },
        //     );
        //   },
        //   child: const Center(
        //     child: Icon(Icons.camera),
        //   ),
        // ),
      ],
    );
  }
}
