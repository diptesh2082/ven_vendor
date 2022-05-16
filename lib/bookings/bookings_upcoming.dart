import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vyam_vandor/Services/firebase_firestore_api.dart';
import 'package:vyam_vandor/constants.dart';

import '../Screens/order_details_screen.dart';
import '../widgets/card_details.dart';

class UpcomingBookings extends StatelessWidget {
  const UpcomingBookings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: MediaQuery.of(context).size.width*.92,
            child:Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
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
                    const Text("No Active Bookings"):
                    ListView.builder(
                      physics:
                      const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: doc.length,
                      itemBuilder: (context, index) {

                        // if (doc[index]['booking_status'] ==
                        //     'active' || doc[index]['booking_status'] =='completed'
                        //     || doc[index]['booking_status'] =='upcoming'
                        // // &&
                        // // doc[index]['booking_accepted'] ==
                        // //     true
                        // // &&
                        // // doc[index]["vendorId"] ==
                        // //     gymId.toString()
                        // )
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
