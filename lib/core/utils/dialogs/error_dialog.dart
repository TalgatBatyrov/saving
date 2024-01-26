import 'package:flutter/cupertino.dart';
import 'package:flutter_translate/flutter_translate.dart';

import 'generic_dialog.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) async {
  return showGenericDialog(
    context: context,
    title: translate('sharing_error'),
    content: text,
    optionsBuilder: () => {translate('ok'): null},
  );
}
