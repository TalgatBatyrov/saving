import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';
import 'package:saving/blocs/statistic_changes/statistic_changes_cubit.dart';
import 'package:saving/utilities/dialogs/delete_dialog.dart';
import '../models/statistic/statistic.dart';

class StatisticTile extends StatefulWidget {
  const StatisticTile({
    super.key,
    required this.statistic,
  });

  final Statistic statistic;

  @override
  State<StatisticTile> createState() => _StatisticTileState();
}

class _StatisticTileState extends State<StatisticTile> {
  bool isEdit = false;

  late final editController =
      TextEditingController(text: widget.statistic.money.toString());
  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat.yMMMd('en_US');
    String date = dateFormat.format(widget.statistic.date);

    return Slidable(
      key: ValueKey(widget.statistic.id),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              isEdit = !isEdit;
              setState(() {});
            },
            label: 'Edit',
            icon: Icons.edit,
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(
          closeOnCancel: true,
          confirmDismiss: () {
            return showDeleteDialog(context);
          },
          onDismissed: () {
            context
                .read<StatisticChangesCubit>()
                .sendRemoveSignal(widget.statistic);
          },
        ),
        children: [
          SlidableAction(
            onPressed: null,
            label: translate('snake_bar.swipe_left'),
            icon: Icons.delete,
          ),
        ],
      ),
      child: Card(
        color: widget.statistic.money > 0 ? Colors.green : Colors.red,
        elevation: 4,
        child: isEdit
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  keyboardType: TextInputType.number,
                  controller: editController,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.all(10),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.green, style: BorderStyle.none),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.green, style: BorderStyle.none),
                    ),
                    prefixIcon: const Icon(Icons.edit, color: Colors.white),
                    suffixIcon: IconButton(
                      onPressed: () {
                        final changedStatistic = widget.statistic
                            .copyWith(money: int.parse(editController.text));
                        context
                            .read<StatisticChangesCubit>()
                            .sendUpdateSignal(changedStatistic);

                        isEdit = !isEdit;
                        setState(() {});
                      },
                      icon: const Icon(Icons.check, color: Colors.white),
                    ),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.green, style: BorderStyle.none),
                    ),
                  ),
                ),
              )
            : ListTile(
                leading: Text(
                  '${widget.statistic.money}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                trailing: Text(
                  date,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
      ),
    );
  }
}
