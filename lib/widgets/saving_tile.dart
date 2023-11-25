import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:saving/blocs/saving/saving_cubit.dart';
import 'package:saving/widgets/dismiss_widget.dart';
import 'package:saving/widgets/money_action.dart';
import 'package:saving/widgets/progress_in_percent.dart';
import 'package:saving/widgets/saving_item.dart';
import 'package:saving/widgets/start_action_pane.dart';

import '../blocs/toggle/toggle_cubit.dart';
import '../models/saving/saving.dart';
import 'change_goal_name_screen.dart';
import 'linear_progress_screen.dart';

class SavingTile extends StatefulWidget {
  final Saving saving;
  const SavingTile({super.key, required this.saving});

  @override
  State<SavingTile> createState() => _SavingTileState();
}

class _SavingTileState extends State<SavingTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    animation = ColorTween(
      begin: Colors.white38,
      end: Colors.green,
    ).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SavingCubit, SavingState>(
      builder: (context, state) => BlocProvider(
        create: (context) => ToggleVisibilityChangeGoalCubit(),
        child: Slidable(
          key: Key(widget.saving.id),
          startActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [StartActionPane(saving: widget.saving)],
          ),
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            dismissible: DismissWidget(saving: widget.saving),
            children: [
              SlidableAction(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(15),
                ),
                onPressed: null,
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                label: translate('snake_bar.swipe_left'),
              ),
            ],
          ),
          child: AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.blue,
                      animation.value!,
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ChangeGoalNameScreen(saving: widget.saving),
                      const SizedBox(height: 5),
                      ProgressInPercent(saving: widget.saving),
                      LinearProgressScreen(saving: widget.saving),
                      const SizedBox(height: 5),
                      SavingItem(
                          title: translate('target'),
                          value: widget.saving.total),
                      const SizedBox(height: 5),
                      SavingItem(
                          title: translate('accumulated'),
                          value: widget.saving.current),
                      const SizedBox(height: 5),
                      SavingItem(
                          title: translate('left'),
                          value: widget.saving.remainder),
                      const SizedBox(height: 5),
                      MoneyAction(saving: widget.saving),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
