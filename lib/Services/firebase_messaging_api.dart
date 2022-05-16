import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vyam_vandor/Screens/home__screen.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:vyam_vandor/Services/firebase_firestore_api.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'My Channel', // title
  description: 'Important notifications from my server.', // description
  importance: Importance.high,
);

var android = const AndroidNotificationDetails(
  'high_importance_channel',
  'main',
  channelDescription: 'CHANNEL DESCRIPTION',
  importance: Importance.max,
  priority: Priority.high,
  enableLights: true,
  enableVibration: true,
  ticker: 'ticker',
);

var ios = const IOSNotificationDetails();

var platform = NotificationDetails(android: android, iOS: ios);

class FirebaseMessagingApi {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  initialize(context) async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      ),
      onSelectNotification: (str) {
        Map map = str as Map;

        print(map);
        print("/////////////");
        print(str);
      },
    );
  }

  Future onbackgroundMessageClick(context) async {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("handler called app is opened");
      Map map = message.data;
      Get.to(()=> HomeScreen());
      print(map['MovieID']);
    }, onError: (e) {
      print(e);
    });
  }

//Method for Notification recieved when app is in Foreround
  Future getforegroundMessages() async {
    try {
      FirebaseMessaging.onMessage.listen(
        (RemoteMessage message) async {
          final tempmessage = message;
          print(tempmessage);

          try {
            await flutterLocalNotificationsPlugin.show(
              0,
              message.notification!.title,
              message.notification!.body,
              platform,
              payload: message.data.toString(),
            );
            print(tempmessage.notification!.body);
            print(tempmessage.notification!.title);
            print(tempmessage.data);
          } on PlatformException catch (e) {
            print("Plat Form Exception ////////");
            print(e);
          } catch (e) {
            print("Non PlatForm Exception");
            print(e);
          }
          print(tempmessage.notification!.body);
        },
      );
    } catch (e) {
      print(e);
    }
  }

  Future getbackgroundNOtificaion() async {
    FirebaseMessaging.onBackgroundMessage(
      firebaseMessagingBackgroundHandler,
    );
  }

  Future firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      ),
      onSelectNotification: (str) {
        print("/////////////");
        print(str!);
      },
    );

    print("Handling a background message: ${message.messageId}");
    print("Handling a background message: ${message.notification}");
    print("Handling a background message: ${message.data}");
    try {
      await flutterLocalNotificationsPlugin.show(
        0,
        message.notification!.title,
        message.notification!.body,
        platform,
        payload: message.data.toString(),
      );
    } catch (e) {
      print(e);
    }
  }

  Future getDevicetoken() async {
    try {
      final token = await _firebaseMessaging.getToken();
      print(token);
      return token;
    } catch (e) {
      print(e);
    }
  }
}
