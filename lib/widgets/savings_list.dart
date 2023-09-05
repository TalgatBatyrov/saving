import 'package:saving/widgets/saving_tile.dart';
import 'package:flutter/material.dart';
import '../models/saving/saving.dart';

class SavingsList extends StatelessWidget {
  final List<Saving> savings;
  const SavingsList({super.key, required this.savings});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      physics: const BouncingScrollPhysics(),
      itemCount: savings.length,
      itemBuilder: (context, i) => SavingTile(saving: savings[i]),
    );
  }
}
