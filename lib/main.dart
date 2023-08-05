import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_my_app/repositories/savings/abstract_savings_repository.dart';
import 'package:flutter_my_app/repositories/savings/models/saving.dart';
import 'package:flutter_my_app/repositories/savings/savings_repository.dart';
import 'package:flutter_my_app/repositories/statistics/abstract_statistics_repository.dart';
import 'package:flutter_my_app/repositories/statistics/statistics_repository.dart';
import 'package:flutter_my_app/repositories/user/auth_repository.dart';
import 'package:get_it/get_it.dart';
import 'savings_app.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  // print('User granted permission: ${settings.authorizationStatus}');

  // print('Token: $token');

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  /// TODO: extract to separate file, ex: HiveService
  await Hive.initFlutter();
  Hive.registerAdapter(SavingAdapter());
  final savingsBox = await Hive.openBox<Saving>('savings_box');

  /// TODO: dont use get it
  GetIt.I.registerLazySingleton<AbstractSavingsRepository>(
    () => SavingsRepository(
      dio: Dio(),
      savingsBox: savingsBox,
      firestore: FirebaseFirestore.instance,
    ),
  );

  GetIt.I.registerLazySingleton<AbstractStatisticsRepository>(
    () => StatisticsRepository(FirebaseFirestore.instance),
  );

  GetIt.I.registerLazySingleton<AuthRepository>(
    () => AuthRepository(
      FirebaseAuth.instance,
      FirebaseFirestore.instance,
    ),
  );

  runApp(const SavingsApp());
}
