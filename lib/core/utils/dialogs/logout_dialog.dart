import 'package:flutter/cupertino.dart';
import 'package:flutter_translate/flutter_translate.dart';

import 'generic_dialog.dart';

Future<bool> showLogOutDialog(
  BuildContext context,
) async {
  return showGenericDialog<bool>(
    context: context,
    title: translate('logout'),
    content: translate('sharing_success'),
    optionsBuilder: () => {
      translate('cancel'): false,
      translate('logout'): true,
    },
  ).then((value) => value ?? false);
}
