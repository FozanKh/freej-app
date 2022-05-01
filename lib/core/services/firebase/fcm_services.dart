import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

import '../api/request_manager.dart';

class FCM {
  static String fcmTokenUrl = '${RequestManger.baseUrl}/auth/fcm-token/';

  static Future<void> init() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('User granted permission', name: 'FCM/init');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      log('User granted provisional permission', name: 'FCM/init');
    } else {
      log('User declined or has not accepted permission', name: 'FCM/init');
      return;
    }

    await messaging.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    String? token = await getFcmToken();

    //Save TokenTo Database
    if (token != null) await FCM.saveFcmTokenToDatabase(token);

    // Any time the token refreshes, store this in the database too.
    FirebaseMessaging.instance.onTokenRefresh.listen(FCM.saveFcmTokenToDatabase);
  }

  static Future<void> saveFcmTokenToDatabase(String token) async {
    var data = {
      "token": token,
    };
    log('Saving FCM Token', name: 'FCM/saveFcmTokenToDatabase');
    await RequestManger.fetchObject(url: fcmTokenUrl, method: Method.POST, body: data);
  }

  static Future<void> removeFcmTokenFromDatabase() async {
    var data = {"token": await getFcmToken()};
    log('Removing FCM Token', name: 'FCM/removeFcmTokenFromDatabase');
    await RequestManger.fetchObject(url: fcmTokenUrl, method: Method.DELETE, body: data);
  }

  static Future<String?> getFcmToken() async {
    return await FirebaseMessaging.instance.getToken();
  }
}
