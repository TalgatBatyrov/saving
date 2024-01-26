import 'package:flutter/cupertino.dart';
import 'package:flutter_translate/flutter_translate.dart';

import 'generic_dialog.dart';

Future<bool> showDeleteDialog(
  BuildContext context,
) async {
  return showGenericDialog<bool>(
    context: context,
    content: translate('delete_dialog'),
    title: translate('delete'),
    optionsBuilder: () => {
      translate('cancel'): false,
      translate('yes'): true,
    },
  ).then((value) => value ?? false);
}
