import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initialize() async {
    // Request permission for notification handling
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('Notification permission granted');
      String? token = await _firebaseMessaging.getToken();
      print('hey this is the tokennnnnn : $token');
    } else {
      print('Notification permission denied');
    }

    // Configure notification handlers
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Handle foreground notification messages
      print('Received foreground notification: ${message.notification!.title}');
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // Handle background notification messages
    print('Received background notification: ${message.notification!.title}');
  }

  Future<String?> getDeviceToken() async {
    String? token = await _firebaseMessaging.getToken();
    print('hey this is the tokennnnnn : $token');
    return token;
  }
}
