import 'package:flutter/cupertino.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:saving/cache.dart';

class ButtonTranslate {
  void showDemoActionSheet({
    required BuildContext context,
    required Widget child,
  }) {
    showCupertinoModalPopup<String>(
        context: context,
        builder: (BuildContext context) => child).then((String? value) {
      if (value != null) changeLocale(context, value);
    });
  }

  void onActionSheetPress(BuildContext context) {
    showDemoActionSheet(
      context: context,
      child: CupertinoActionSheet(
        title: Text(translate('language')),
        actions: [
          CupertinoActionSheetAction(
            child: const Text('English'),
            onPressed: () {
              Navigator.pop(context, 'en');
              const LocalCache().saveTranslate('en');
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Українська'),
            onPressed: () {
              Navigator.pop(context, 'uk');
              const LocalCache().saveTranslate('uk');
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Руский'),
            onPressed: () {
              Navigator.pop(context, 'ru');
              const LocalCache().saveTranslate('ru');
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Polski'),
            onPressed: () {
              Navigator.pop(context, 'pl');
              const LocalCache().saveTranslate('pl');
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('español'),
            onPressed: () {
              Navigator.pop(context, 'sp');
              const LocalCache().saveTranslate('sp');
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('português'),
            onPressed: () {
              Navigator.pop(context, 'pr');
              const LocalCache().saveTranslate('kr');
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Кыргызча'),
            onPressed: () {
              Navigator.pop(context, 'kr');
              const LocalCache().saveTranslate('kr');
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () => Navigator.pop(context, null),
          child: Text(translate('cancel')),
        ),
      ),
    );
  }
}
