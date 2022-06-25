import 'package:flutter/cupertino.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'notification_api.dart';

//import '../golbal_variables.dart';

class NotificationDetails extends StatefulWidget {
  const NotificationDetails({
    Key? key,
  }) : super(key: key);

  @override
  State<NotificationDetails> createState() => _NotificationDetailsState();
}

class _NotificationDetailsState extends State<NotificationDetails> {
  List events = [];
  List notificationList = [];

  NotificationApi notificationApi = NotificationApi();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.back,
            color: HexColor("3A3A3A"),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Notifications",
          style: GoogleFonts.poppins(
              color: HexColor("3A3A3A"),
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: notificationApi.getnotification,
          builder: (_, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            final data = snapshot.data.docs;
            print(data.length);

            if (data.length == 0) {
              return Center(
                child: Image.asset(
                  "Assets/Images/notification empty.png",
                ),
              );
            }
            return  Column(
              children: [
                SizedBox(
                  height: _height * 0.7,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount:data.length<=15 ? data.length:15,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            elevation: 8,
                            color: Colors.transparent,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8)),
                              width: _width * 0.9,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 22.0, left: 18, bottom: 22),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        if (data[index]["status"].toString().toLowerCase()=="cancelled")
                                          SizedBox(
                                            child: Text("Your booking has been canceled ${data[index]["user_name"].toString()} ❌",
                                              maxLines: 2,
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14
                                              ),
                                            ),
                                            width: MediaQuery.of(context).size.width*.75,
                                          ),
                                        if (data[index]["status"].toString().toLowerCase()=="completed")
                                        // Booking completed ${data[index]["user_name"].toString()}
                                          SizedBox(
                                            child: Text("Booking completed ${data[index]["user_name"].toString()}",
                                              maxLines: 2,
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14
                                              ),
                                            ),
                                            width: MediaQuery.of(context).size.width*.75,
                                          ),

                                        if (data[index]["status"].toString().toLowerCase()=="active")
                                          SizedBox(
                                            child: Text("Booking activated  ${data[index]["user_name"]} ✅",
                                              maxLines: 2,
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14
                                              ),
                                            ),
                                            width: MediaQuery.of(context).size.width*.75,
                                          ),
                                        if (data[index]["status"].toString().toLowerCase()=="upcoming")
                                          SizedBox(
                                            child: Text("Booking successful for ${data[index]["vendor_name"]} ✅",
                                              maxLines: 2,
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14
                                              ),
                                            ),
                                            width: MediaQuery.of(context).size.width*.75,
                                          ),

                                        const SizedBox(
                                          width: 0,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    if (data[index]["status"].toString().toLowerCase()=="completed")
                                      SizedBox(
                                        child: Text("Eat well & take some rest 😇",
                                          maxLines: 2,
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12
                                          ),
                                        ),
                                        width: MediaQuery.of(context).size.width*.7,
                                      ),
                                    if (data[index]["status"].toString().toLowerCase()=="active")
                                      SizedBox(
                                        child: Text("Stay hydrated. 🚰",
                                          maxLines: 2,
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12
                                          ),
                                        ),
                                        width: MediaQuery.of(context).size.width*.7,
                                      ),
                                    if (data[index]["status"].toString().toLowerCase()=="upcoming")
                                      SizedBox(
                                        child: Text("Share OTP at the center to start. (body)",
                                          maxLines: 2,
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12
                                          ),
                                        ),
                                        width: MediaQuery.of(context).size.width*.7,
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                SizedBox(
                  height: 50,
                ),
                // InkWell(
                //   onTap: () async {
                //     // try {
                //  await FirebaseFirestore.instance
                //           .collection("booking_notifications")
                //           .where("user_id",isEqualTo: number).get().then((value) {
                //             value.docs.forEach((element) {
                //               element.data().update("seen", (value) => true);
                //             });
                //         // for (DocumentSnapshot ds in value.docs) {
                //         //   ds.reference.update({
                //         //     "seen":true
                //         //   });
                //         // }
                //       });
                //     // } catch (e) {
                //     //   return null;
                //     // };
                //   },
                //   child: Container(
                //     width: _width * 0.9,
                //     height: 50,
                //     decoration: BoxDecoration(
                //         color: HexColor("292F3D"),
                //         borderRadius: BorderRadius.circular(8)),
                //     child: Center(
                //       child: Text(
                //         "Clear all",
                //         style: GoogleFonts.poppins(
                //             color: HexColor("FFFFFF"),
                //             fontSize: 16,
                //             fontWeight: FontWeight.w700),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            );
          }),
    );
  }
}
