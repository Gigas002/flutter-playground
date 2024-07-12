import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotification {
  
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {}
    );
  }

  Future showNotification({int id = 0, String? title, String? body, String? payload}) async {
    return flutterLocalNotificationsPlugin.show(
      id, title, body, const NotificationDetails(android: AndroidNotificationDetails('channelId', 'channelName'))
    );
  }
}
