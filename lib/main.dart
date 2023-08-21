import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'savings_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  // print("Handling a background message: ${message.messageId}");
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

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.notification != null) {
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

  runApp(const SavingsApp());
}
