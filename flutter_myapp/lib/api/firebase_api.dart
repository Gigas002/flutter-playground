import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_myapp/app.dart';
import 'package:flutter_myapp/notification/notification.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('[LOG] HANDLE_BACKGROUND_MESSAGE');
  // print('Title: ${message.notification?.title}');
  // print('Body: ${message.notification?.body}');
  // print('Payload: ${message.data}');
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> handleMessage(RemoteMessage? message) async {
    if (message == null) return;

    print('[LOG] HANDLE_MESSAGE');
    navigatorKey.currentState?.pushNamed(
      NotificationPage.route,
      arguments: message,
    );
  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance
      .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
      FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
      FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print('Token: $fCMToken');
    initPushNotifications();
  }
}
