import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Services/firebase_firestore_api.dart';
import 'order_details_screen.dart';

class CollectCashPage extends StatelessWidget {
  const CollectCashPage({Key? key,required this.userID, required this.bookingID,required this.amount,required this.online}) : super(key: key);
  final userID;
  final bookingID;
  final amount;
  final bool online;

  @override
  Widget build(BuildContext context) {
    var _width=MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 373,
              width: MediaQuery.of(context).size.width * 0.9,
              // margin: EdgeInsets.fromLTRB(16.0, 74.0, 16.0, 397.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: Colors.orange,
              ),
              // padding: EdgeInsets.fromLTRB(61.0, 122.0, 63.0, 126.0),
              child: SizedBox(
                child: online?
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Amount Collected",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      "Online",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 30.0,
                      ),
                    ),
                  ],
                ):Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Collect Cash",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      "\₹ ${amount} ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 40.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: SizedBox(
            width: _width * 0.9,
            child: FloatingActionButton.extended(
              elevation: 0,
              splashColor: Colors.amber,
              // backgroundColor: HexColor("292F3D"),
              autofocus: false,
              focusElevation: 4,
              backgroundColor: Color(0xff292F3D),
              // focusNode: FocusScope.of(context).unfocus();
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              onPressed: () async {
                await FirebaseFirestoreAPi()
                    .acceptandUpdatebookingStatus(
                  bookingID,
                  userID,
                );
                await FirebaseFirestore.instance
                    .collection('bookings')
                    .doc(bookingID)
                    .update({
                  "booking_accepted": true,
                  "booking_status":"active"
                });
                Get.off(
                  OrderDetails(
                    chinki: true,
                    userID: userID,
                    bookingID: bookingID,
                  ),
                );
              },
              label: Text(
                "Done",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold, color: Colors.white,fontSize: 16),
              ),
            )
          // : Container(),
        ),
      ),
    );
  }
}