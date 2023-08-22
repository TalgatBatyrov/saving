import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

abstract class PushNotifications {
  static final _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'flutter_notification',
    'flutter_notification_title',
    importance: Importance.high,
    enableLights: true,
    enableVibration: true,
    showBadge: true,
    playSound: true,
    ledColor: Colors.red,
  );

  static void initialize() async {
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

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        showNotification(
          message.notification!.hashCode,
          message.notification!.title,
          message.notification!.body,
          payload: message.data.toString(),
        );
      }
    });

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  static void showNotification(
    int id,
    String? title,
    String? body, {
    required String payload,
  }) {
    _flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          priority: Priority.high,
          importance: Importance.max,
          setAsGroupSummary: true,
          styleInformation: const DefaultStyleInformation(true, true),
          icon: '@mipmap/ic_launcher',
        ),
      ),
      payload: payload,
    );
  }
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  if (message.notification != null) {
    PushNotifications.showNotification(
      message.notification!.hashCode,
      message.notification!.title,
      message.notification!.body,
      payload: message.data.toString(),
    );
  }
}
