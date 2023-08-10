import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:convert';

class FcmRepository {
  final Dio _dio = Dio()
    ..options = BaseOptions(
      baseUrl: "https://fcm.googleapis.com/",
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'key=AAAAjh5zc1w:APA91bFjdSscPvwqKCZrisa8xSKOQMwrw2tOL5W0_aVB79zbWSF4u-eoTMdkZd4BE3oaeMvO4SXnpx6_ioSJXUGhLqtv5Me3Kjtx4r7lhPAGVm4HuBuN29TKFGbimVho53jcyRBc9Y88',
      },
    );

  final FirebaseMessaging _firebaseMessaging;

  FcmRepository(this._firebaseMessaging);

  Future<void> sendNotification({
    required String title,
    required String body,
  }) async {
    try {
      final token = await _firebaseMessaging.getToken();

      final data = {
        "to": token,
        "notification": {
          "title": title,
          "body": body,
        },
        "priority": "high",
        "data": {
          "click_action": "FLUTTER_NOTIFICATION_CLICK",
          "id": "1",
          "status": "done",
        },
      };

      await _dio.post(
        'fcm/send',
        data: jsonEncode(data),
      );
    } catch (error) {
      // print('Ошибка при отправке уведомления: $error');
    }
  }
}
