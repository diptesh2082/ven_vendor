import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:vyam_vandor/Services/firebase_firestore_api.dart';
import 'package:vyam_vandor/constants.dart';
import 'package:vyam_vandor/controllers/gym_controller.dart';
import 'package:vyam_vandor/widgets/active_booking.dart';
import 'package:vyam_vandor/widgets/card_details.dart';

import '../Screens/order_details_screen.dart';



// import '../Screens/home__screen.dart';
// import '../Screens/login_screen.dart';
// import '../Screens/order_details_screen.dart';

class AllSales extends StatefulWidget {
  const AllSales({Key? key}) : super(key: key);

  @override
  State<AllSales> createState() => _AllSalesState();
}

class _AllSalesState extends State<AllSales> {

  @override
  void dispose() {
    // TODO: implement dispose
    // bookingController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    String salesTotal = '\$260';
    String salesStatus = '+ \$20';
    String bookingsTotal = '70';
    String bookingsStatus = '+ 3';
    // sales() async{
    final stream =
    FirebaseFirestore.instance.collectionGroup('user_booking').snapshots();

    final _auth=FirebaseAuth.instance;
    Size size=MediaQuery.of(context).size;

    // .where("vendorId", isEqualTo: "dipteshmandal555@gmail.com").where("booking_accepted", isEqualTo: true)

    // return stream;
    // }
    var bookings=0;
    int sum = 0;

    return Scaffold(
      backgroundColor: kScaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: MediaQuery.of(context).size.width*.92,
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('bookings')
                      .where("vendorId",isEqualTo: gymId)
                      .orderBy("booking_date",descending: true)
                      .where("booking_status".toLowerCase(),isEqualTo: "upcoming")
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot snap) {
                    if (snap.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snap.data == null) {
                      return const Text("No Active Bookings");
                    }
                    var doc = snap.data.docs;
                    // if (snap.hasData){
                    //
                    // }

                    return doc.length==0?
                    const Text("No Upcoming Bookings"):
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Material(
                              child: Container(

                                height: 196,
                                 decoration: BoxDecoration(
                                   color: Colors.white,
                                   borderRadius: BorderRadius.circular(15),
                                 ),
                                child:Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset("Assets/Images/UPI-logo.png",
                                      height: 30,
                                      width: 60,
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text("Online Payment",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500
                                    ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text("₹ 200",
                                      style: GoogleFonts.poppins(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700
                                      ),
                                    )
                                  ],
                                ),
                                 width: MediaQuery.of(context).size.width*.41,
                              ),
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            elevation: 5,
                          ),
                          Spacer(),
                          Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(15),
                              child: Container(
                                height: 196,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child:Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset("Assets/Images/bi_cash.png",
                                      height: 35,
                                      width: 60,
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text("Cash Payment",
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text("₹ 500",
                                      style: GoogleFonts.poppins(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700
                                      ),
                                    )
                                  ],
                                ),
                                width: MediaQuery.of(context).size.width*.41,
                              ),
                            color: Colors.white,

                          ),
                        ],
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
