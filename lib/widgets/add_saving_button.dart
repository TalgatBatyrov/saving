import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:saving/blocs/currency/currency_cubit.dart';
import 'package:saving/blocs/saving/saving_cubit.dart';

class AddSavingButton extends StatelessWidget {
  const AddSavingButton({super.key});

  @override
  Widget build(BuildContext context) {
    final goalController = TextEditingController();
    final totalController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return IconButton(
      onPressed: () {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Spacer(),
                    Text(
                      translate('add_saving'),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    TextFormField(
                      controller: goalController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.savings),
                        labelText: translate('saving'),
                        hintText: translate('enter_saving'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value == null) {
                          return 'Пожалуйста, введите название накопления';
                        }
                        if (value.isEmpty) {
                          return 'Пожалуйста, введите название накопления';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: totalController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.money),
                        labelText: translate('total'),
                        hintText: translate('enter_total'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value == null) {
                          return 'Пожалуйста, введите сумму накопления';
                        }
                        if (value.isEmpty) {
                          return 'Пожалуйста, введите сумму накопления';
                        }
                        return null;
                      },
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context.read<SavingCubit>().createSaving(
                                goal: goalController.text.trim(),
                                total: totalController.text.isNotEmpty
                                    ? int.parse(totalController.text)
                                    : 0,
                                currencyState:
                                    context.read<CurrencyCubit>().state.name,
                              );

                          goalController.clear();
                          totalController.clear();
                          context.router.pop();
                        }
                      },
                      child: Text(translate('add_saving')),
                    ),
                    TextButton(
                      onPressed: context.router.pop,
                      child: Text(translate('cancel')),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            );
          },
        );
      },
      icon: const Icon(Icons.add),
    );
  }
}
