import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:saving/core/services/push_notifications.dart';

import 'app/app.dart';
import 'core/services/local_cache.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  PushNotifications.initialize();
  final selectedLanguageCode = await const LocalCache().getLanguage();
  var delegate = await LocalizationDelegate.create(
    fallbackLocale: 'ru',
    supportedLocales: ['uk', 'ru', 'en', 'kr', 'pl', 'pr', 'sp'],
  );
  delegate.changeLocale(Locale(selectedLanguageCode));

  runApp(
    LocalizedApp(
      delegate,
      const App(),
    ),
  );
}
