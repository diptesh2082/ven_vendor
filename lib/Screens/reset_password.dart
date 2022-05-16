import 'package:flutter/material.dart';
import 'package:vyam_vandor/Services/firebase_auth_api.dart';
import 'package:vyam_vandor/widgets/custom_text_field.dart';
import 'package:vyam_vandor/widgets/primary_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResetPassScreen extends StatefulWidget {
  const ResetPassScreen({Key? key}) : super(key: key);

  @override
  _ResetPassScreen createState() => _ResetPassScreen();
}

class _ResetPassScreen extends State<ResetPassScreen> {
  TextEditingController? _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController!.dispose();
  }

  Future _signIn() async {
    try {
      FirebaseAuthApi().signIn(
        email: _emailController!.text.trim(),
        context: context,
      );
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 90,
                ),
                CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 75,
                  child: Image.asset(
                    "Assets/Images/log.png",
                    height: 80,
                    width: 80,
                  ),
                ),
                const SizedBox(height: 60),
                CustomTextFiled(
                  hintText: 'Username',
                  textEditingController: _emailController,
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 55,
                ),
                buildPrimaryButton(
                  () {
                    FirebaseAuth.instance
                        .sendPasswordResetEmail(email: _emailController!.text);
                    Navigator.of(context).pop();
                  },
                  'Send Request',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
