import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vyam_vandor/Services/firebase_firestore_api.dart';
import 'package:vyam_vandor/constants.dart';

import '../Screens/booking_summary_screen.dart';
import '../Screens/order_details_screen.dart';
import '../widgets/booking_card.dart';
import '../widgets/card_details.dart';

class UpcomingBookings extends StatefulWidget {
  final filter;

  const UpcomingBookings({Key? key,required this.filter,}) : super(key: key);

  @override
  State<UpcomingBookings> createState() => _UpcomingBookingsState();
}

class _UpcomingBookingsState extends State<UpcomingBookings> {
  // DateTimeRange? _selectDateTime;
  // DateTimeRange _selectDateTime= DateTimeRange(
  //      start: DateTime.utc(DateTime.now().year,DateTime.now().month,DateTime.now().day-60),
  //      end:DateTime.utc(DateTime.now().year,DateTime.now().month,DateTime.now().day+60),
  //    ) ;
  // void _show()async
  // {
  //   final DateTimeRange? result = await showDateRangePicker(context: context, firstDate: DateTime(2022 , 1), lastDate: DateTime(2030 , 12 ,31),
  //       currentDate: DateTime.now(),
  //       saveText: 'Done'
  //   );
  //   if(result != null)
  //   {
  //     print(result.start.toString());
  //     setState(() {
  //       _selectDateTime = result;
  //     });
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    print(widget.filter);
    print("++++++++++++++++++++++++++++++++");
    // if(widget.filter=="custom"){
    //   _show();
    // }
    super.initState();
  }

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
                      .where("booking_status".toLowerCase(),whereIn: ["active","upcoming","completed","canceled"])
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
                        if((doc[index]['booking_date'].toDate().isAfter(widget.filter.start)   && doc[index]['booking_date'].toDate().isBefore(widget.filter.end))
                            || doc[index]['booking_date'].toDate() == widget.filter.start
                            || doc[index]['booking_date'].toDate() == widget.filter.end
                        )
                        {

                          return GestureDetector(
                            onTap: () async {
                              // print("wewe");
                              // if(doc[index]['booking_status']=="upcoming"){
                              //   Get.to(
                              //         () => BookingScreen(
                              //       otp: doc[index]['otp_pass'],
                              //       bookingID: doc[index]['booking_id'],
                              //       userID: doc[index]['userId'],
                              //     ),
                              //     // arguments: {
                              //     //   "booking_id": widget.bookingID,
                              //     // }
                              //   );
                              // }else{
                              //   await OrderDetails(
                              //     userID: doc[index]['userId'],
                              //     bookingID: doc[index]
                              //     ['booking_id'],
                              //     imageUrl: doc[index]
                              //     ["gym_details"]["images"],
                              //   );
                              // }

                            },
                            child: CardDetails(
                              bookind_end: doc[index]['plan_end_duration'].toDate(),
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
                              otp:  int.parse(doc[index]['otp_pass']),

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
