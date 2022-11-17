import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

class NotificationApi {
  // ระบบ notification ชั่วคราวสำหรับการใส่ otp verification
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static Future init() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iOS = IOSInitializationSettings();
    const settings = InitializationSettings(android: android, iOS: iOS);
    await _notifications.initialize(settings,
        onSelectNotification: (payload) async {
      onNotifications.add(payload);
    });
  }

  static Future showNotification(
      String title, String body, String payload) async {
    return _notifications.show(1, title, body, await notificationDetails(),
        payload: payload);
  }

  static Future notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails('channel Id', 'channel Name',
          importance: Importance.max),
      iOS: IOSNotificationDetails(),
    );
  }

  void sendNotification(
      String token, String title, String body, String id, String status) async {
    try {
      print('Process Send Successfully');
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAArDOghis:APA91bGXXGf6dj2dlJtRt6oOtyou2tB6AEc_2eKE6bht-QvDp5XOvq6akKAty1UT0w3kbwvWB2aVOrSnnqbJ15YZK3g2RHVk3yghYP_SeW7PKOOlqgGsUAlzYTbQ4I8c1Zc_skPDw2Fc'
        },
        body: json.encode(
          {
            'priority': 'high',
            'data': {
              'id': id,
              'status': status,
            },
            'notification': {
              'title': title,
              'body': body,
              'android_channel_id': 'kbmnoti',
            },
            'to': token,
          },
        ),
      );
    } catch (e) {
      print('Process Send Failed');
      rethrow;
    }
  }
}
