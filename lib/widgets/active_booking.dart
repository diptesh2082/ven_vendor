import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vyam_vandor/Screens/booking_summary_screen.dart';
import 'package:vyam_vandor/Screens/order_details_screen.dart';

class ActiveBookingCard extends StatefulWidget {
  const ActiveBookingCard({
    Key? key,
    required this.userName,
    required this.bookingID,
    required this.bookingdate,
    required this.bookingPlan,
    required this.bookingPrice,
    required this.userID,
    this.tempYear,
    this.tempDay,
    this.tempMonth,
    this.id,
  }) : super(key: key);
  final String? userName;
  final String? bookingID;
  final String? bookingdate;
  final String? bookingPlan;
  final double? bookingPrice;
  final String? userID;
  final dynamic tempYear;
  final dynamic tempDay;
  final dynamic tempMonth;
  final String? id;

  @override
  State<ActiveBookingCard> createState() => _ActiveBookingCardState();
}

class _ActiveBookingCardState extends State<ActiveBookingCard> {
  @override
  void initState() {
    print(widget.tempDay);
    print(widget.tempYear);
    print(widget.tempMonth);
    super.initState();
    print("//////////////////");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
            () => OrderDetails(
                  // otp: widget.otp,
                  bookingID: widget.bookingID,
                  userID: widget.userID,
                ),
            arguments: {
              "booking_id": widget.bookingID,
            });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        height: 130,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Material(
                  // color: Colors.yellowAccent,
                  borderRadius: BorderRadius.circular(5),
                  elevation: 5,
                  // color: Colors.yellow,
                  // decoration: BoxDecoration(
                  //   color: Colors.yellowAccent,
                  //   borderRadius: BorderRadius.circular(5)
                  // ),
                  child:Padding(
                    padding: const EdgeInsets.only(left: 3,right: 2,top: 1,bottom: 1),
                    child: RichText(
                        text: TextSpan(
                            style: GoogleFonts.poppins(
                              // fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: Colors.grey),
                            children:  <TextSpan>[
                              TextSpan(
                                  text: 'Booking ID - '
                              ),
                              TextSpan(
                                  text: '${widget.id}',
                                  style:GoogleFonts.poppins(
                                    // fontFamily: "Poppins",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                      color: Colors.amber
                                  )
                              ),
                            ]

                        )),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(2.0),
                  //   child: Text(
                  //     '${widget.id}',
                  //     style:
                  //     GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 10),
                  //   ),
                  // ),
                ),
                Text(
                  widget.userName!,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700, fontSize: 15),
                ),
                Text(
                  widget.bookingdate!,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                ),
                Text(
                  widget.bookingPlan!,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Text(
                    '\₹${widget.bookingPrice}',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600, fontSize: 18,
                        color: Colors.amber
                    ),
                  ),
                ),
                Text(
                  '${DateTime.now().difference(DateTime(int.parse(widget.tempYear), int.parse(widget.tempMonth), int.parse(widget.tempDay))).inDays} days remaining',
                  style:GoogleFonts.poppins(fontWeight: FontWeight.w500),
                ),
                Row(
                  children:  [
                    CircleAvatar(
                      radius: 3,
                      backgroundColor: Colors.green,
                    ),
                    SizedBox(
                      width: 3.5,
                    ),
                    Text(
                      'Active',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
