import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vyam_vandor/Services/firebase_firestore_api.dart';

import '../Screens/get_location_screen.dart';
import '../Screens/home__screen.dart';
import 'custom_exceptions.dart';


class FirebaseAuthApi {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String get getEmail => name!;

  String? name;
  String? email;
  String? photoUrl;

  Future signIn({
    String? email,
    String? password,
    BuildContext? context,
  }) async {
    try {
      print(email);
      print(password);
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email!, password: password!);
      print(userCredential);
      gymId= await userCredential.user!.email;
      this.email = userCredential.user!.email;
      name = userCredential.user!.displayName;
      photoUrl = userCredential.user!.photoURL;
      //Go to Home Page
      final isLocationAvailable =
          await FirebaseFirestoreAPi().checkIslocationAlreadyUpdated();

      if (isLocationAvailable) {

        // gymId= FirebaseAuth.instance.currentUser!.email;
        // gymId= await FirebaseAuth.instance.currentUser!.email;
        FirebaseFirestoreAPi().updateTokenToFirebase();
        Navigator.pushAndRemoveUntil(
          context!,
          MaterialPageRoute(
            builder: ((context) =>  HomeScreen()),
          ),
          (route) => false,
        );
      } else {
        //GetLocationScreen
        Navigator.pushAndRemoveUntil(
          context!,
          MaterialPageRoute(
            builder: ((context) => const GetLocationScreen()),
          ),
          (route) => false,
        );
      }

      print("User Sent to Home Page");
    } on FirebaseAuthException catch (e) {
      CustomAuthExceptions().handleAuthExceptions(e.code, context);
    } catch (e) {
      print("/../");
      print(e);
    }
  }
}
