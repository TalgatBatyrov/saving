import 'package:flutter/cupertino.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:saving/core/services/local_cache.dart';

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

  final cache = const LocalCache();

  void onActionSheetPress(BuildContext context) {
    showDemoActionSheet(
      context: context,
      child: CupertinoActionSheet(
        title: Text(translate('language')),
        actions: [
          CupertinoActionSheetAction(
            child: const Text('English'),
            onPressed: () {
              cache.saveLanguage('en');
              Navigator.pop(context, 'en');
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Українська'),
            onPressed: () {
              Navigator.pop(context, 'uk');
              cache.saveLanguage('uk');
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Русский'),
            onPressed: () {
              Navigator.pop(context, 'ru');
              cache.saveLanguage('ru');
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Polski'),
            onPressed: () {
              Navigator.pop(context, 'pl');
              cache.saveLanguage('pl');
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('español'),
            onPressed: () {
              Navigator.pop(context, 'sp');
              cache.saveLanguage('sp');
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('português'),
            onPressed: () {
              Navigator.pop(context, 'pr');
              cache.saveLanguage('pr');
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Кыргызча'),
            onPressed: () {
              Navigator.pop(context, 'kr');
              cache.saveLanguage('kr');
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
