import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vyam_vandor/Screens/reset_password.dart';
import 'package:vyam_vandor/Services/firebase_auth_api.dart';
import 'package:vyam_vandor/widgets/custom_text_field.dart';
import 'package:vyam_vandor/widgets/primary_button.dart';

import 'Tabs/support_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController? _emailController;
  TextEditingController? _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController!.dispose();
    _passwordController!.dispose();
  }

  Future _signIn() async {
    try {
      FirebaseAuthApi().signIn(
        email: _emailController!.text.trim(),
        password: _passwordController!.text,
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
                CustomTextFiled(
                  hintText: 'Password',
                  textEditingController: _passwordController,
                  obscure: true,
                ),
                const SizedBox(
                  height: 5,
                ),
                // TextButton(
                //   child: Padding(
                //     padding: const EdgeInsets.only(right: 15.0),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.end,
                //       children: const [
                //         Text("Forgot password?",
                //             style: TextStyle(
                //               fontSize: 16,
                //               color: Colors.grey,
                //             )),
                //       ],
                //     ),
                //   ),
                //   onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                //       builder: ((context) => ResetPassScreen()))),
                // ),
                const SizedBox(
                  height: 55,
                ),
                buildPrimaryButton(
                  () {
                    _signIn();
                  },
                  'log in',
                ),
                const SizedBox(
                  height: 150,
                ),
                TextButton(onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContactUs(),
                    ));}, child: Text('Support',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w700

                ),
                ),)
                // buildPrimaryButton(
                //       () {
                //
                //           Navigator.push(
                //               context,
                //               MaterialPageRoute(
                //                 builder: (context) => ContactUs(),
                //               ));
                //         },
                //
                //   'Support',
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
