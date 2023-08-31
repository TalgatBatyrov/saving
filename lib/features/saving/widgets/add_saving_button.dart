import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import '../blocs/saving_cubit.dart';

class AddSavingButton extends StatelessWidget {
  const AddSavingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            final goalController = TextEditingController();
            final totalController = TextEditingController();
            return AlertDialog(
              title:  Text(translate('add-Saving')),
              content: SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.2,
                child: Column(
                  children: [
                    TextField(
                      controller: goalController,
                      decoration: InputDecoration(
                        labelText: translate('saving'),
                        hintText: translate('enter_saving'),
                      ),
                    ),
                    TextField(
                      controller: totalController,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        FilteringTextInputFormatter.deny(RegExp(r'^0+'))
                      ],
                      decoration:  InputDecoration(
                        labelText: translate('total'),
                        hintText: translate('enter_total'),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      context.read<SavingCubit>().createSaving(
                            goal: goalController.text,
                            total: totalController.text.isNotEmpty
                                ? int.parse(totalController.text)
                                : 0,
                          );
                      context.router.pop();
                    },
                    child:  Text(translate('add_saving'))),
                TextButton(
                  onPressed: context.router.pop,
                  child: Text(translate('cancel')),
                ),
              ],
            );
          },
        );
      },
      icon: const Icon(Icons.add),
    );
  }
}
