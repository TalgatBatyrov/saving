import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              title: const Text('Add Saving'),
              content: SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.2,
                child: Column(
                  children: [
                    TextField(
                      controller: goalController,
                      decoration: const InputDecoration(
                        labelText: 'Saving',
                        hintText: 'Enter saving',
                      ),
                    ),
                    TextField(
                      controller: totalController,
                      decoration: const InputDecoration(
                        labelText: 'Total',
                        hintText: 'Enter total',
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
                    child: const Text('Add Saving')),
                TextButton(
                  onPressed: context.router.pop,
                  child: const Text('Cancel'),
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
