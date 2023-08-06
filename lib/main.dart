import 'package:saving/repositories/savings/abstract_savings_repository.dart';
import 'package:saving/repositories/savings/models/saving.dart';
import 'package:saving/repositories/savings/savings_repository.dart';
import 'package:saving/repositories/statistics/statistics_repository.dart';
import 'package:saving/repositories/user/auth_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'repositories/statistics/abstract_statistics_repository.dart';
import 'savings_app.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

AndroidNotificationChannel? channel = const AndroidNotificationChannel(
  'flutter_notification',
  'flutter_notification_title',
  importance: Importance.high,
  enableLights: true,
  enableVibration: true,
  showBadge: true,
  playSound: true,
  ledColor: Colors.red,
);

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
  final token = await messaging.getToken();
  print('Token: $token');

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print(
          'Message also contained a notification: ${message.notification?.title} ${message.notification?.body}');

      flutterLocalNotificationsPlugin.show(
        message.notification.hashCode,
        message.notification!.title,
        message.notification!.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel!.id,
            channel!.name,
            priority: Priority.high,
            importance: Importance.max,
            setAsGroupSummary: true,
            styleInformation: const DefaultStyleInformation(true, true),
            channelShowBadge: true,
            autoCancel: true,
            icon: '@mipmap/ic_launcher',
          ),
        ),
        payload: message.data.toString(),
      );
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
