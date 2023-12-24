import 'package:flutter/material.dart';
import 'package:saving/widgets/saving_tile.dart';

import '../models/saving/saving.dart';

class SavingsList extends StatelessWidget {
  final List<Saving> savings;
  const SavingsList({super.key, required this.savings});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, i) => const Divider(),
      padding: const EdgeInsets.all(8),
      physics: const BouncingScrollPhysics(),
      itemCount: savings.length,
      itemBuilder: (context, i) => SavingTile(saving: savings[i]),
    );
  }
}
