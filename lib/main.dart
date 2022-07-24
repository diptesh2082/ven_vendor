import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:vyam_vandor/Screens/book_details_dashboard.dart';
import 'package:vyam_vandor/Screens/login_screen.dart';
import 'package:vyam_vandor/Services/firebase_firestore_api.dart';
import 'package:vyam_vandor/widgets/dashboard_map.dart';
import 'Screens/home__screen.dart';

late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("A bg message just showed up : ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  try {
    gymId = await FirebaseAuth.instance.currentUser!.email;
  } catch (e) {
    gymId = null;
  }

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Noti'
            'fications', // title
        description:
            'This channel is used for important notifications.', // description
        importance: Importance.high,
        playSound: true);

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: Color(0xffF4F4F4),
        statusBarIconBrightness: Brightness.light),
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  void initState() {
    // TODO: implement initState
    FirebaseMessaging.instance.getInitialMessage();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              //channel.description,
              icon: 'launcher_icon',
            ),
          ),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published');
      // final routeFromMessage = message.data["GymDetails"];
      // print(routeFromMessage);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // if (FirebaseAuth.instance.currentUser!.email != null)
    // gymId = FirebaseAuth.instance.currentUser!.email;
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.yellow,
          fontFamily: 'PoppinsRegular',
          appBarTheme: const AppBarTheme(
            elevation: 0.0,
          )),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            return HomeS(

                // email: gymId,
                );
          }
          return const LoginScreen();
        },
      ),
    );
  }
}
