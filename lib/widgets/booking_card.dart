import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vyam_vandor/Screens/booking_summary_screen.dart';
import 'package:get/get.dart';

class BookingCard extends StatefulWidget {
  const BookingCard(
      {Key? key,
      this.userName = "",
      this.bookingID = "",
      this.bookingdate = "",
      this.bookingPlan = "",
      this.bookingPrice = 0.0,
      this.userID = "",
      this.bookings,
      this.docs,
      this.id,
      required this.otp})
      : super(key: key);

  final String? userName;
  final String? bookingID;
  final String? bookingdate;
  final String? bookingPlan;
  final double? bookingPrice;
  final String? userID;
  final int? otp;
  final Map? bookings;
  final Map? docs;
  final String? id;

  @override
  State<BookingCard> createState() => _BookingCardState();
}

class _BookingCardState extends State<BookingCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.to(
                () => BookingScreen(
              otp: widget.otp,
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
                  color: Colors.white,
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
                  '${widget.userName}',
                  style:
                      const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                ),
                //TODO: Add Booking Dates to the Text Widget
                Text(
                  widget.bookingdate!,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(
                  '${widget.bookingPlan}',
                  style: const TextStyle(fontWeight: FontWeight.w500),
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
                    '\₹ ${widget.bookingPrice}',
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    // print("The otp for booking is : ${widget.bookingID}");
                    print(widget.otp);
                    print(widget.bookingID);
                    print(widget.userID);
                    print(widget.bookingPlan);
                    print(widget.bookingdate);

                    Get.to(
                        () => BookingScreen(
                              otp: widget.otp,
                              bookingID: widget.bookingID,
                              userID: widget.userID,
                            ),
                        arguments: {
                          "booking_id": widget.bookingID,
                        });
                  },
                  child: const Text(
                    'Accept',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.green,
                    ),
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 5,
                      ),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
