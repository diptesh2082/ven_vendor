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
            final data = snapshot.requireData;
            print(data.size);

            if (data.size == 0) {
              return Center(
                child: Image.asset(
                  "Assets/Images/notification empty.png",
                ),
              );
            }
            return Column(
              children: [
                SizedBox(
                  height: _height * 0.7,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.size,
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
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: RichText(
                                        text: TextSpan(
                                            text: data.docs[index]['title'],
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: HexColor("3A3A3A"),
                                            ),
                                            children: [
                                              TextSpan(
                                                  text:
                                                      '\n${data.docs[index]['description']}',
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: HexColor("AFAFAF"),
                                                  ))
                                            ]),
                                        maxLines: 3,
                                      ),
                                    ),
                                    if (data.docs[index]['type']
                                        .contains("reminder"))
                                      const Icon(
                                        Icons.warning_amber,
                                        color: Colors.red,
                                      ),
                                    if (data.docs[index]['type']
                                        .contains("coupon"))
                                      Image.asset("Assets/Images/discount.png"),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                InkWell(
                  onTap: () {
                    notificationApi.clearNotificationList();
                  },
                  child: Container(
                    width: _width * 0.9,
                    height: 50,
                    decoration: BoxDecoration(
                        color: HexColor("292F3D"),
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Text(
                        "Clear all",
                        style: GoogleFonts.poppins(
                            color: HexColor("FFFFFF"),
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
