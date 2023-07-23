import 'package:flutter/material.dart';
import 'package:flutter_my_app/features/saving/widgets/saving_tile.dart';

import '../../../repositories/savings/models/saving.dart';

class SavingsList extends StatelessWidget {
  final List<Saving> savings;
  const SavingsList({
    super.key,
    required this.savings,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: savings.length,
      separatorBuilder: (context, i) => const Divider(thickness: 2),
      itemBuilder: (context, i) => SavingTile(saving: savings[i]),
    );
  }
}
