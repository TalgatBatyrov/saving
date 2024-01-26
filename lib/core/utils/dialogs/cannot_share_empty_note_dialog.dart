import 'package:flutter/cupertino.dart';
import 'package:flutter_translate/flutter_translate.dart';

import 'generic_dialog.dart';

Future<void> showCannotEmptyNoteDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: translate('sharing'),
    content: translate('sharing_empty_note'),
    optionsBuilder: () => {
      translate('ok'): null,
    },
  );
}
