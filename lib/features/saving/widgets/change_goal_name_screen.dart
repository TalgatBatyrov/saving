import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saving/features/toggle/toggle_cubit.dart';

import '../../../repositories/savings/models/saving.dart';
import '../blocs/saving_cubit.dart';

class ChangeGoalNameScreen extends StatefulWidget {
  final Saving saving;
  const ChangeGoalNameScreen({super.key, required this.saving});

  @override
  State<ChangeGoalNameScreen> createState() => _ChangeGoalNameScreenState();
}

class _ChangeGoalNameScreenState extends State<ChangeGoalNameScreen> {
  final _goalController = TextEditingController();

  void _changeGoalName({
    required SavingCubit savingCubit,
    required Saving saving,
  }) {
    final goalName = _goalController.text;
    final isGoalNameEquals = goalName == saving.goal;

    if (goalName.isNotEmpty && !isGoalNameEquals) {
      savingCubit.changeSavingTitle(
        title: goalName,
        savingId: saving.id,
      );
    }
  }

  @override
  void initState() {
    _goalController.text = widget.saving.goal;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final savingCubit = context.read<SavingCubit>();
    return BlocBuilder<ToggleVisibilityChangeGoalCubit, bool>(
      builder: (context, state) {
        return Visibility(
          visible: state,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: TextField(
                  controller: _goalController,
                  decoration: const InputDecoration(
                    labelText: 'Название цели',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Expanded(
                child: IconButton(
                  onPressed: () {
                    _changeGoalName(
                      savingCubit: savingCubit,
                      saving: widget.saving,
                    );
                    context.read<ToggleVisibilityChangeGoalCubit>().toggle();
                  },
                  icon: const Icon(Icons.edit),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
