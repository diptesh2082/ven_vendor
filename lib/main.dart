import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vyam_vandor/Screens/book_details_dashboard.dart';
import 'package:vyam_vandor/Screens/login_screen.dart';

import 'package:vyam_vandor/Services/firebase_firestore_api.dart';

import 'Screens/home__screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  try {
    gymId = await FirebaseAuth.instance.currentUser!.email;
  } catch (e) {
    gymId = null;
  }

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: Color(0xffF4F4F4),
        statusBarIconBrightness: Brightness.light),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // if (FirebaseAuth.instance.currentUser!.email != null)
    // gymId = FirebaseAuth.instance.currentUser!.email;
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.purple,
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
            return HomeScreen(
                // email: gymId,
                );
          }
          return const LoginScreen();
        },
      ),
    );
  }
}
