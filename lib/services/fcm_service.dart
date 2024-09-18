import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initialize() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Pesan diterima di foreground: ${message.notification?.title}');

      // Tangani notifikasi yang diterima
      if (message.notification != null) {
        // Misalnya tampilkan dialog atau update UI
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Pesan dibuka dari background: ${message.notification?.title}');

      // Navigasi ke chat room atau halaman tertentu berdasarkan data notifikasi
      final roomId = message.data['roomId'];
      if (roomId != null) {
        // Arahkan ke chat room tertentu
      }
    });
  }
}
