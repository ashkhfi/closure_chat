import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  NotificationService() {
    _initialize();
  }

  Future<void> _initialize() async {
    await _requestPermission();

    // Initialize local notifications
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await _notificationsPlugin.initialize(initializationSettings);

    // Handle foreground notifications
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      String payloadData = jsonEncode(message.data);
      print('Got a message while in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
        showSimpleNotification(
            title: message.notification!.title!,
            body: message.notification!.body!,
            payload: payloadData);
      }
    });

    // Handle background and terminated notifications
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Notification was tapped and app was opened!');
      // You can handle the notification tap action here
    });

    // Optionally, handle the case when the app is launched from a terminated state by a notification
    RemoteMessage? initialMessage =
        await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      print('App was launched from notification tap!');
      // Handle the notification here
    }
  }

  Future<void> _requestPermission() async {
    var status = await Permission.notification.request();
    if (status.isGranted) {
      print('Izin notifikasi diberikan');
    } else {
      print('Izin notifikasi ditolak');
    }
  }

 static Future<void> showSimpleNotification({
  required String title,
  required String body,
  required String payload,
}) async {
  const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
    'your_channel_id',
    'your_channel_name',
    channelDescription: 'your_channel_description',
    importance: Importance.max,
    priority: Priority.high,
    ticker: 'ticker',
  );
  
  const NotificationDetails notificationDetails = NotificationDetails(
    android: androidNotificationDetails,
  );
  
  await _notificationsPlugin.show(0, title, body, notificationDetails, payload: payload);
}

}
