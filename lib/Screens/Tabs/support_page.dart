import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

//import '../../golbal_variables.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            title: Text("Contact Us"),
            centerTitle: true,
            foregroundColor: Color(0xff3A3A3A),
            backgroundColor: Colors.grey[100],
            elevation: 0,
            automaticallyImplyLeading: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.pop(context, false),
              color: Color(0xff3A3A3A),
            ),
          ),
          body: StreamBuilder<DocumentSnapshot>(
            stream:  FirebaseFirestore.instance.collection("app_details").doc("contact_us").snapshots(),
            builder: (context,AsyncSnapshot snapshot) {
              if(snapshot.connectionState==ConnectionState.waiting){
                return Container(
                    color: Colors.white,
                    child: Center(child: CircularProgressIndicator()));
              }
              return Column(
                children: [
                  ListTile(
                    onTap: () async {
                      var email = "${snapshot.data.get("email")}";
                      print(email);
                      String emailUrl = "mailto: ${email.toString()}";
                      if (await canLaunch(emailUrl)) {
                        await launch(emailUrl);
                      } else {
                        throw "Error occured trying to call that number.";
                      }
                    },
                    leading: Icon(
                      FontAwesomeIcons.envelope,
                      color: Color(0xff292D32),
                      size: 20,
                    ),
                    title: Text(
                      "${snapshot.data.get("email")}",
                      style: GoogleFonts.poppins(
                          fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(
                    child: Divider(
                      color: Color(0xffE9E9E9),
                      thickness: 1.5,
                      height: 5,
                    ),
                  ),
                  ListTile(
                    onTap: ()async{
                      final url =
                          "${snapshot.data.get("instaId")}";
                      if (await canLaunch(url)) {
                      await launch(
                      url,
                      forceSafariVC: false,
                      );
                      }
                    },
                    leading: Icon(
                      FontAwesomeIcons.instagram,
                      color: Color(0xff292D32),
                      size: 20,
                    ),
                    title: Text(
                      '@vyam',
                      style: GoogleFonts.poppins(
                          fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                  ),
                  Divider(
                    color: Color(0xffE9E9E9),
                    thickness: 1.5,
                    height: 5,
                  ),
                  ListTile(
                    onTap: () async {
                      var number = "${snapshot.data.get("phonenumber")}";
                      print(number);
                      String telephoneUrl = "tel:${number.toString()}";
                      if (await canLaunch(telephoneUrl)) {
                        await launch(telephoneUrl);
                      } else {
                        throw "Error occured trying to call that number.";
                      }
                    },
                    leading: Icon(
                      FontAwesomeIcons.phone,
                      color: Color(0xff292D32),
                      size: 20,
                    ),
                    title: Text(
                      "${snapshot.data.get("phonenumber")}",
                      style: GoogleFonts.poppins(
                          fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                  ),
                  ListTile(
                    onTap: () async {
                      final url = "https:${snapshot.data.get("website")}";
                      if (await canLaunch(url)) {
                        await launch(
                          url,
                          forceSafariVC: false,
                        );
                      }
                    },
                    leading: Icon(
                      FontAwesomeIcons.earthAmericas,
                      color: Color(0xff292D32),
                      size: 20,
                    ),
                    title: Text(
                      "${snapshot.data.get("website")}",
                      style: GoogleFonts.poppins(
                          fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              );
            }
          )),
    );
  }
}
