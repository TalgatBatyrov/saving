import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:saving/blocs/saving/saving_cubit.dart';
import 'package:saving/router/router.dart';
import 'package:saving/widgets/dismiss_widget.dart';
import 'package:saving/widgets/money_action.dart';
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
  void dispose() {
    _controller.dispose();
    super.dispose();
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
              return GestureDetector(
                onTap: () {
                  context.router.push(StatisticRoute(saving: widget.saving));
                },
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      ChangeGoalNameScreen(saving: widget.saving),
                      const SizedBox(height: 10),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 10,
                            runSpacing: 10,
                            verticalDirection: VerticalDirection.down,
                            children: [
                              SavingContainer(
                                  title: translate('target'),
                                  value: widget.saving.total,
                                  color: const Color.fromARGB(190, 20, 20, 20),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(50),
                                    topRight: Radius.circular(12),
                                    bottomLeft: Radius.circular(12),
                                    bottomRight: Radius.circular(50),
                                  )),
                              SavingContainer(
                                  title: translate('accumulated'),
                                  value: widget.saving.current,
                                  color: const Color.fromARGB(190, 20, 20, 20),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(50),
                                    bottomLeft: Radius.circular(50),
                                    bottomRight: Radius.circular(12),
                                  )),
                              SavingContainer(
                                title: translate('left'),
                                value: widget.saving.remainder,
                                color: const Color.fromARGB(190, 20, 20, 20),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(50),
                                  bottomLeft: Radius.circular(50),
                                  bottomRight: Radius.circular(12),
                                ),
                              ),
                              LinearProgressScreen(saving: widget.saving),
                            ],
                          ),
                          MoneyAction(saving: widget.saving),
                        ],
                      ),
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

class SavingContainer extends StatelessWidget {
  final String title;
  final Color color;
  final int value;
  final BorderRadiusGeometry borderRadius;
  const SavingContainer({
    super.key,
    required this.title,
    required this.value,
    required this.color,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            textAlign: TextAlign.center,
            value.toString(),
            style: const TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
