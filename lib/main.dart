import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:saving/services/push_notifications.dart';
import 'savings_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  PushNotifications.initialize();

  final delegate = await LocalizationDelegate.create(
    fallbackLocale: 'en',
    supportedLocales: ['en', 'uk', 'kr', 'pl', 'pr', 'ru', 'sp'],
  );

  runApp(
    LocalizedApp(
      delegate,
      const SavingsApp(),
    ),
  );
}
