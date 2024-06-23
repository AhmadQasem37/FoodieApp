import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:food_delivery/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FireBaseMsg {

  final _fireBaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _fireBaseMessaging.requestPermission();

    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool("fromProfile", false);
    // await preferences.setStringList("notifications", []);
    final FCMToken = await _fireBaseMessaging.getToken();
    print("Token  $FCMToken");

    initPushNotifications();
  }


  // Handel received notifications

  void handelMsg(RemoteMessage? msg)  {

    if (msg == null) return;

    // navigate to notification page and show the notifications
    // Navigator.of(context).pushReplacementNamed("NotificationPage");
    navigationKey.currentState?.pushNamed("/NotificationPage", arguments:msg );
  }

  // Function to initialize background settings
  Future initPushNotifications() async {
    // handle notification if the app terminated and now opened
    FirebaseMessaging.instance.getInitialMessage().then(handelMsg);
    // attach event listeners for when a notification opens the app
    FirebaseMessaging.onMessageOpenedApp.listen((handelMsg));
  }

}