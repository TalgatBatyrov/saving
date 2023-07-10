import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_app/features/saving/bloc/saving_cubit.dart';
import 'package:flutter_my_app/repositories/savings/models/saving.dart';

import '../bloc/saving_state.dart';

@RoutePage()
class SavingPage extends StatefulWidget {
  final Saving saving;
  final SavingCubit savingCubit;
  const SavingPage({
    super.key,
    required this.saving,
    required this.savingCubit,
  });

  @override
  State<SavingPage> createState() => _SavingPageState();
}

class _SavingPageState extends State<SavingPage> {
  final _addController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SavingCubit, SavingState>(
        bloc: widget.savingCubit,
        builder: (context, state) {
          if (state is SavingLoaded) {
            return Scaffold(
              appBar: AppBar(
                title: Text(widget.saving.goal),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Всего ${widget.saving.total}'),
                  Text('Осталось ${widget.saving.remaining}'),
                  Text('Сейчас ${widget.saving.current}'),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: _addController,
                    decoration: const InputDecoration(
                      labelText: 'Добавить',
                    ),
                  ),
                  TextButton(
                      onPressed: () async {
                        final saving = widget.saving;
                        final valueExists = _addController.text.isNotEmpty;
                        final addValue = int.parse(_addController.text);
                        final current = valueExists ? (saving.current + addValue) : 0;

                        await context.read<SavingCubit>().updateSaving(
                              saving.copyWith(
                                current: current,
                                remaining: saving.remaining - addValue,
                              ),
                            );
                      },
                      child: const Text('Добавить')),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        });
  }
}
