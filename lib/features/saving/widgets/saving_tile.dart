import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_app/features/saving/bloc/saving_cubit.dart';
import 'package:flutter_my_app/features/saving/widgets/saving_item.dart';
import 'package:share_plus/share_plus.dart';
import '../../../repositories/savings/models/saving.dart';
import '../../../router/router.dart';
import '../bloc/statistic/statistic_cubit.dart';

class SavingTile extends StatefulWidget {
  final Saving saving;
  const SavingTile({
    super.key,
    required this.saving,
  });

  @override
  State<SavingTile> createState() => _SavingTileState();
}

class _SavingTileState extends State<SavingTile> {
  final _addController = TextEditingController();
  final _goalController = TextEditingController();
  bool _isEditing = false;

  void _changeGoalName(SavingCubit savingCubit) {
    final saving = widget.saving;
    final goalName = _goalController.text;
    final valueExists = goalName.isNotEmpty;

    if (valueExists) {
      savingCubit.updateSaving(
        saving.copyWith(goal: goalName),
      );
    }
    _isEditing = !_isEditing;
  }

  void _addSaving(SavingCubit savingCubit) {
    final saving = widget.saving;
    final addValue = _addController.text;
    final valueExists = addValue.isNotEmpty;

    if (valueExists) {
      final addValueInt = int.parse(addValue);
      final current = valueExists ? (saving.current + addValueInt) : 0;

      savingCubit.updateSaving(
        saving.copyWith(
          current: current <= 0 ? 0 : current,
          remaining: saving.remaining - addValueInt,
        ),
      );

      context.read<StatisticCubit>().add(
            money: addValueInt,
            savingId: saving.id,
          );
    }

    _addController.clear();
  }

  void _subtractSaving(SavingCubit savingCubit) {
    final saving = widget.saving;
    final addValue = _addController.text;
    final valueExists = addValue.isNotEmpty;

    if (valueExists) {
      final addValueInt = int.parse(addValue);
      final current = valueExists ? (saving.current - addValueInt) : 0;

      savingCubit.updateSaving(
        saving.copyWith(
          current: current <= 0 ? 0 : current,
          remaining: saving.remaining + addValueInt,
        ),
      );
      context.read<StatisticCubit>().add(
            money: -addValueInt,
            savingId: saving.id,
          );
    }
    _addController.clear();
  }

  String _buildSavingMessage(Saving saving) {
    final percentage = (saving.current / saving.total * 100).toInt();
    return 'Цель: ${saving.goal}\nНакоплено: ${saving.current}\nОсталось: ${saving.remaining}\nВ %: $percentage';
  }

  @override
  Widget build(BuildContext context) {
    final savingCubit = context.read<SavingCubit>();
    final saving = widget.saving;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shadowColor: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Visibility(
                visible: _isEditing,
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
                        onPressed: () => _changeGoalName(savingCubit),
                        icon: const Icon(Icons.edit),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: !_isEditing ? 0 : 10),
              InkWell(
                onTap: () {
                  _isEditing = !_isEditing;
                  _goalController.text = saving.goal;
                  setState(() {});
                },
                child: Center(
                  child: Text(
                    saving.goal,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Visibility(
                visible: saving.isCompleted,
                child: const Text('Цель достигнута!'),
              ),
              const SizedBox(height: 10),
              LinearProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  saving.isCompleted ? Colors.green : Colors.red,
                ),
                minHeight: 15,
                value: saving.current / saving.total,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SavingItem(title: 'Цель', value: saving.total),
                  SavingItem(title: 'Накоплено', value: saving.current),
                  SavingItem(title: 'Осталось', value: saving.remaining),
                  SavingItem(
                    title: 'В %',
                    value: (saving.current / saving.total * 100).toInt(),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: _addController,
                      decoration: const InputDecoration(
                        labelText: 'Добавить',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      onPressed: () => _addSaving(savingCubit),
                      icon: const Icon(
                        Icons.add,
                        color: Colors.green,
                        size: 40,
                      ),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      onPressed: () => _subtractSaving(savingCubit),
                      icon: const Icon(
                        Icons.remove,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Удалить цель?'),
                              content: const Text(
                                'Вы уверены, что хотите удалить цель?',
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Нет')),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    savingCubit.deleteSaving(saving.id);
                                  },
                                  child: const Text('Да'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  // share
                  Expanded(
                    child: IconButton(
                      onPressed: () async {
                        final message = _buildSavingMessage(saving);
                        await Share.share(message);
                      },
                      icon: const Icon(Icons.share, color: Colors.blue),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      onPressed: () async {
                        AutoRouter.of(context)
                            .push(SavingRoute(saving: saving));
                      },
                      icon: const Icon(Icons.history, color: Colors.green),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
