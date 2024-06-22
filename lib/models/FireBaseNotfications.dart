import 'package:firebase_messaging/firebase_messaging.dart';

class FireBaseMsg {
  final _fireBaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _fireBaseMessaging.requestPermission();

    final FCMToken = await _fireBaseMessaging.getToken();

    print("Token  $FCMToken");
  }

}



