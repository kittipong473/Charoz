import 'dart:convert';
import 'package:charoz/Model/Api/Request/notification_request.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings('launcher');

    DarwinInitializationSettings iosInitializationSettings =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) async {},
    );

    InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );
    await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) async {},
    );
  }

  Future showNotification(
      {int id = 0, String? title, String? body, String? payload}) async {
    return notificationsPlugin.show(
        id, title, body, await notificationDetails());
  }

  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'channelName',
            importance: Importance.max),
        iOS: DarwinNotificationDetails());
  }

  void sendNotification(NotificationRequest model) async {
    try {
      await http
          .post(
            Uri.parse('https://fcm.googleapis.com/fcm/send'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization':
                  'key=AAAArDOghis:APA91bGXXGf6dj2dlJtRt6oOtyou2tB6AEc_2eKE6bht-QvDp5XOvq6akKAty1UT0w3kbwvWB2aVOrSnnqbJ15YZK3g2RHVk3yghYP_SeW7PKOOlqgGsUAlzYTbQ4I8c1Zc_skPDw2Fc'
            },
            body: json.encode(
              {
                'priority': 'high',
                'to': model.token,
                'notification': {
                  'title': model.title,
                  'body': model.body,
                  'android_channel_id': 'kbmnoti',
                },
                'data': model.payload!.toJson(),
              },
            ),
          )
          .then((_) => print('Process Send Successfully'));
    } catch (e) {
      print('Process Send Failed');
      rethrow;
    }
  }
}
