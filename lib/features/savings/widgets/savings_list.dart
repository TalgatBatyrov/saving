import 'package:flutter/material.dart';
import 'package:saving/features/savings/repository/models/saving/saving.dart';
import 'package:saving/features/savings/widgets/saving_tile.dart';

class SavingsList extends StatelessWidget {
  final List<Saving> savings;
  const SavingsList({super.key, required this.savings});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, i) => const Divider(),
      physics: const BouncingScrollPhysics(),
      itemCount: savings.length,
      itemBuilder: (context, i) => SavingTile(saving: savings[i]),
    );
  }
}
