import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:saving/features/blocs/toggle/toggle_cubit.dart';
import 'package:saving/features/savings/bloc/saving_cubit.dart';
import 'package:saving/features/savings/repository/models/saving/saving.dart';
import 'package:saving/features/savings/widgets/goal_title.dart';

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
        return Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 0.8,
          padding: const EdgeInsets.all(8),
          child: Visibility(
            replacement: GoalTitle(saving: widget.saving),
            visible: state,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      controller: _goalController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(8),
                        labelText: translate('target_name'),
                        labelStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                      ),
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
          ),
        );
      },
    );
  }
}
