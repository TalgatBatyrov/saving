import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:saving/services/push_notifications.dart';
import 'local_cache.dart';
import 'savings_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  PushNotifications.initialize();
  final selectedLanguageCode = await const LocalCache().getLanguage();
  var delegate = await LocalizationDelegate.create(
    fallbackLocale: 'en',
    supportedLocales: ['en', 'uk', 'kr', 'pl', 'pr', 'ru', 'sp'],
  );
  delegate.changeLocale(Locale(selectedLanguageCode));

  runApp(
    LocalizedApp(
      delegate,
      const SavingsApp(),
    ),
  );
}

class Counter {
  int value;

  Counter({required this.value});

  void increment() => value++;
}
