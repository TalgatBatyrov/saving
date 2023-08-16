import 'package:flutter/cupertino.dart';

import 'generic_dialog.dart';

Future<void> showCannotEmptyNoteDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Sharing',
    content: 'You cannot share empty note!',
    optionsBuilder: () => {
      'OK': null,
    },
  );
}
