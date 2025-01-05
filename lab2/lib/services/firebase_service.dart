import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:lab2/main.dart';

class FirebaseServices {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();

    print("Token: $fCMToken");
    initPushNotifications();
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    navigatorKey.currentState?.pushNamed(
      '/notification_screen',
      arguments: message,
    );
  }

  Future initPushNotifications() async {
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      handleMessage(message); // Handle foreground notifications
    });

    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
}