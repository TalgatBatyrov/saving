import 'package:saving/features/saving/widgets/saving_tile.dart';
import 'package:flutter/material.dart';
import '../../../repositories/savings/models/saving.dart';

class SavingsList extends StatelessWidget {
  final List<Saving> savings;
  const SavingsList({super.key, required this.savings});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: savings.length,
      separatorBuilder: (context, i) => const Divider(),
      itemBuilder: (context, i) => SavingTile(saving: savings[i]),
    );
  }
}
