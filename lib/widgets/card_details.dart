import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vyam_vandor/Screens/booking_summary_screen.dart';
import 'package:vyam_vandor/Screens/order_details_screen.dart';

class CardDetails extends StatefulWidget {


  const CardDetails(
      {Key? key,
        required this.id,
        required this.userName,
        required this.bookingID,
        required this.bookingdate,
        required this.bookingPlan,
        required this.bookingPrice,
        required this.userID,
        this.tempYear,
        this.tempDay,
        this.tempMonth,
        required this.booking_status,
        required this.bookind_end})
      : super(key: key);
  final String? id;
  final String? userName;
  final String? bookingID;
  final String? bookingdate;
  final String? bookingPlan;
  final double? bookingPrice;
  final String? userID;
  final dynamic tempYear;
  final dynamic tempDay;
  final dynamic tempMonth;
  final String booking_status;
  final DateTime bookind_end;

  @override
  State<CardDetails> createState() => _CardDetailsState();
}

class _CardDetailsState extends State<CardDetails> {
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
      onTap: (){
        Get.to(
                () => OrderDetails(
              // otp: widget.otp,
              bookingID: widget.bookingID,
              userID: widget.userID,
            ),
            arguments: {
              "booking_id":widget.bookingID,
            }
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        height:108,

        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Text(
                //   'Booking ID - ${widget.bookingID!}',
                //   style:
                //   const TextStyle(fontWeight: FontWeight.w400, fontSize: 10),
                // ),
                RichText(
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
                Text(
                  widget.userName!,
                  style:
                  GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14),
                ),
                Text(
                  widget.bookingdate!,
                  style:GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 12),
                ),
                Text(
                  widget.bookingPlan!,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w400,fontSize: 10,
                  color: Colors.grey
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Text(
                    '\₹ ${widget.bookingPrice}',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                ),
                // Text(
                //   '${DateTime.now().difference(DateTime(int.parse(widget.tempYear), int.parse(widget.tempMonth), int.parse(widget.tempDay))).inDays} days remaining',
                //   style:GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 14),
                // ),
                if(widget.booking_status.toString()=="active" && widget.bookind_end.difference(DateTime.now()).inDays >= 0  )
                  Text(
                    // "${widget.end_date.toDate()}",
                    '${widget.bookind_end.difference(DateTime.now()).inDays} days remaining',
                    style:GoogleFonts.poppins(fontWeight: FontWeight.w500),
                  ),
                if(widget.bookind_end.difference(DateTime.now()).inDays < 0 && widget.booking_status.toString()=="active")
                  Text(
                    // "${widget.end_date.toDate()}",
                    'Booking Ended',
                    style:GoogleFonts.poppins(fontWeight: FontWeight.w500),
                  ),
                Row(
                  children:  [
                    CircleAvatar(
                      radius: 3,
                      backgroundColor: widget.booking_status.toString()=="active" && widget.bookind_end.difference(DateTime.now()).inDays >= 0 ?Colors.green:Colors.amber,
                    ),
                    SizedBox(
                      width: 3.5,
                    ),
                    Text(
                      '${widget.booking_status.toString()=="active" && widget.bookind_end.difference(DateTime.now()).inDays <= 0 ?"completed":widget.booking_status}',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w400,fontSize: 10,color: Colors.grey),
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
