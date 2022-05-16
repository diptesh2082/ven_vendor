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

import '../order_details_screen.dart';

// import '../Screens/home__screen.dart';
// import '../Screens/login_screen.dart';
// import '../Screens/order_details_screen.dart';

class AllTimeSales extends StatefulWidget {
  const AllTimeSales({Key? key}) : super(key: key);

  @override
  State<AllTimeSales> createState() => _AllTimeSalesState();
}

class _AllTimeSalesState extends State<AllTimeSales> {

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
                    ListView.builder(
                      physics:
                      const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: doc.length,
                      itemBuilder: (context, index) {

                        if (doc[index]['booking_status'] ==
                            'active' || doc[index]['booking_status'] =='completed'
                            || doc[index]['booking_status'] =='upcoming'
                        // &&
                        // doc[index]['booking_accepted'] ==
                        //     true
                        // &&
                        // doc[index]["vendorId"] ==
                        //     gymId.toString()
                        )
                        {

                          return GestureDetector(
                            onTap: () async {
                              // print("wewe");
                              await OrderDetails(
                                userID: doc[index]['userId'],
                                bookingID: doc[index]
                                ['booking_id'],
                                imageUrl: doc[index]
                                ["gym_details"]["images"],
                              );
                            },
                            child: CardDetails(
                              userID:
                              doc[index]['userId'] ?? "",
                              userName:
                              doc[index]['user_name'] ?? "",
                              bookingID: doc[index]
                              ['booking_id'] ??
                                  "",
                              bookingPlan: doc[index]
                              ['booking_plan'] ??
                                  "",
                              bookingPrice: double.parse(
                                  doc[index]['booking_price']
                                      .toString()),
                              bookingdate: DateFormat(
                                  DateFormat.YEAR_MONTH_DAY)
                                  .format(
                                doc[index]['booking_date']
                                    .toDate(),
                                // bookingsStatus: ,
                              ),
                              tempYear:
                              DateFormat(DateFormat.YEAR)
                                  .format(
                                doc[index]['booking_date']
                                    .toDate(),
                              ),
                              tempDay:
                              DateFormat(DateFormat.DAY)
                                  .format(
                                doc[index]['booking_date']
                                    .toDate(),
                              ),
                              tempMonth: DateFormat(
                                  DateFormat.NUM_MONTH)
                                  .format(
                                doc[index]['booking_date']
                                    .toDate(),
                              ),
                              booking_status: '${doc[index]['booking_status'].toString()}',
                            ),
                          );
                        }

                        return Container();
                      },
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
