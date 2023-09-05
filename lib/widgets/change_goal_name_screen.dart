import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:saving/blocs/saving/saving_cubit.dart';
import 'package:saving/blocs/toggle/toggle_cubit.dart';
import 'package:saving/widgets/goal_title.dart';
import '../repositories/savings/models/saving.dart';

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
        return state
            ? Visibility(
                visible: state,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: _goalController,
                        decoration: InputDecoration(
                          labelText: translate('target_name'),
                          border: const OutlineInputBorder(),
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
                          context
                              .read<ToggleVisibilityChangeGoalCubit>()
                              .toggle();
                        },
                        icon: const Icon(Icons.edit),
                      ),
                    ),
                  ],
                ),
              )
            : GoalTitle(saving: widget.saving);
      },
    );
  }
}
