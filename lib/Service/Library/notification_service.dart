import 'dart:convert';
import 'package:charoz/Model/Data/notification_request.dart';
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
                  'key=AAAA_V-3dhw:APA91bGIfovKHnTwf7yMNG9mlxM7JuCTsGO_DEQ1YJs5kpNUIEhXeSDBXSdrip2q3huoznBL4WlshI9YbpwwXnRkhuf9s_XNJhjzv6Bange7lAlzhvWHh8lOWZEyhD95uO2S5ua0x3B2'
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
                'data': {
                  'id': model.id,
                  'status': model.status,
                },
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
