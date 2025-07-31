
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FcmApi {
  final firebaseMessaging = FirebaseMessaging.instance;
  Future<void> handlepermision() async {
    NotificationSettings settings = await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  Future<String?> getToken() async{
    final fcmtoken = await firebaseMessaging.getToken();

    return fcmtoken;

  }

  Future<void> initNotifications() async {
    await getToken();
    await firebaseMessaging.requestPermission();
    handleForeground();


    FirebaseMessaging.onBackgroundMessage(handleBackgroundFcm);
    FirebaseMessaging.onMessageOpenedApp;


  }
  handleForeground() async{
    // create channel
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description:  'This channel is used for important notifications.',
      importance: Importance.max,
    );
    // create channel on device.
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      log("${notification?.title}");

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                icon: 'img',

              ),
            ));
      }
    });

  }

  static Future<void> handleBackgroundFcm(RemoteMessage message) async {

  }


}
