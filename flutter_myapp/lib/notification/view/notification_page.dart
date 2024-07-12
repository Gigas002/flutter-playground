import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_myapp/widgets/widgets.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});
  static const route = '/notification-page';

  @override
  Widget build(BuildContext context) {
    print('[LOG] NOTIFICATION_PAGE');
    final message = ModalRoute.of(context)!.settings.arguments as RemoteMessage;

    return Scaffold(
      appBar: TitleBar(
        context: context,
        customTitle: const Text("Notification Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${message.notification?.title}'),
            Text('${message.notification?.body}'),
            Text('${message.data}'),
          ],
        ),
      ),
    );
  }
}
