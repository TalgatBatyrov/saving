import 'package:flutter/material.dart';
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

  runApp(const SavingsApp());
}
