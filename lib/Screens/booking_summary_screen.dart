import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vyam_vandor/Screens/collect_cash.dart';
import 'package:vyam_vandor/Screens/order_details_screen.dart';
import 'package:vyam_vandor/Services/firebase_firestore_api.dart';
import 'package:vyam_vandor/app_colors.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
// import com.tekartik.sqflite.SqflitePlugin;

class BookingScreen extends StatefulWidget {
  const BookingScreen({
    Key? key,
    this.otp,
    this.bookingID = "Def booking Id",
    this.userID = "def user iD",
    // this.imageUrl = "Assets/Images/rect.png",
  }) : super(key: key);

  final int? otp;

  final String? userID;
  final String? bookingID;
  // final String? imageUrl;

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  String amount="";
  bool online=false;
  @override
  void initState() {
    print("The otp in booking screen is : ${widget.otp}");
    _controller = TextEditingController();
    super.initState();
  }

  TextEditingController? _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Booking Summary',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('bookings')
                  .doc(widget.bookingID)
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Container();
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                print(snapshot.data);

                return Column(
                  children: [
                    //Container 1 for Booking Summary
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0)),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 9,
                          ),
                          StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('product_details')
                                  .doc(gymId)
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot3) {
                                if (snapshot3.data == null) {
                                  return Container();
                                }
                                if (snapshot3.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                                // print(snapshot3.data);
                                amount=snapshot.data.get('grand_total').toString();
                                online=snapshot.data.get('payment_done');
                                print(
                                    snapshot.data!.get('gym_details')["image"]);
                                return FittedBox(
                                  child: Container(
                                    height: 130,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 0.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          child: Stack(
                                            children: [
                                              CachedNetworkImage(
                                                progressIndicatorBuilder: (context,
                                                        url,
                                                        downloadProgress) =>
                                                    Center(
                                                        child: CircularProgressIndicator(
                                                            value:
                                                                downloadProgress
                                                                    .progress)),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                                fit: BoxFit.cover,
                                                height: 130,
                                                imageUrl: snapshot.data!.get(
                                                    'gym_details')["image"],
                                              ),
                                            ],
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        const SizedBox(
                                          width: 9.0,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '${snapshot.data!.get('gym_details')["name"] ?? ""}',
                                              style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 15.0,
                                            ),
                                            Row(
                                              children: [
                                                Image.asset(
                                                    "Assets/Images/marker.png"),
                                                const SizedBox(
                                                  width: 2.0,
                                                ),
                                                Text(
                                                  snapshot3.data
                                                      .get('landmark'),
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 15.0,
                                            ),
                                            SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.5,
                                                child: Text(
                                                  snapshot3.data.get('address'),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                          const SizedBox(
                            height: 9.0,
                          ),
                          const Divider(
                            height: 2,
                            color: Color(0xffE2E2E2),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                left: 9, right: 9, bottom: 6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'Workout',
                                      style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.green),
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      'Package',
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      'Start date',
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 6.0,
                                    ),
                                    Text(
                                      'Valid upto',
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${snapshot.data.get('booking_plan')}',
                                      style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.green),
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      DateFormat(DateFormat.YEAR_MONTH_DAY)
                                          .format(snapshot.data
                                              .get('booking_date')
                                              .toDate()),
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      DateFormat(DateFormat.YEAR_MONTH_DAY)
                                          .format(snapshot.data
                                              .get('booking_date')
                                              .toDate()),
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      DateFormat(DateFormat.YEAR_MONTH_DAY)
                                          .format(snapshot.data
                                              .get('plan_end_duration')
                                              .toDate()),
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 7.0,
                    ),

                    const SizedBox(
                      height: 6.0,
                    ),
                    //Container For Pricing
                    Container(
                      padding: const EdgeInsets.only(
                          left: 12, right: 12, bottom: 6, top: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Payment',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(
                            height: 9.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total Amount',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(
                                height: 3.0,
                              ),
                              Text(
                                '\$ ${snapshot.data.get('booking_price')}',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff3A3A3A),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 3.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Discount',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                '\$ ${snapshot.data.get('discount')}',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff3A3A3A),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 3.0,
                          ),
                          Text(
                            'Promo code',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          //Taxes and charges
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Text(
                          //       'Taxes and Charges',
                          //       style:GoogleFonts.poppins(
                          //         fontSize: 16,
                          //         fontWeight: FontWeight.w500,
                          //         color: Colors.black,
                          //       ),
                          //     ),
                          //     Text(
                          //       '\$ ${snapshot.data.get('discount')}',
                          //       style: GoogleFonts.poppins(
                          //         fontSize: 16,
                          //         fontWeight: FontWeight.w700,
                          //         color: Color(0xff3A3A3A),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Grand Total',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.green,
                                ),
                              ),
                              const SizedBox(
                                height: 3.0,
                              ),
                              Text(
                                '\$ ${snapshot.data.get('grand_total')}',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    //Container For Customer Details
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.only(
                          left: 9, right: 9, top: 6, bottom: 6),
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('bookings')
                              .doc(widget.bookingID)
                              .snapshots(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot2) {
                            if (snapshot2.data == null) {
                              return Container();
                            }
                            if (snapshot2.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Customers Details',
                                  style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff3A3A3A)),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  'Username: ${snapshot2.data.get("user_name")}',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  'Phone Number: ${snapshot2.data.get('userId')}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Payment Method :  ',
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Material(
                                      color: Colors.green,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 5.0,right: 5),
                                        child: Text(
                                          snapshot2.data.get('payment_done')?"Online":"Cash",
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      elevation: 5,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                              ],
                            );
                          }),
                    )
                  ],
                );
              }),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(12),
          ),
          height: 53,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: TextFormField(
                  controller: _controller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    hintText: 'Enter OTP',
                    hintStyle: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: const Color(0xffC9C9C9),
                    ),
                  ),
                ),
              ),
              // const Spacer(),
              Positioned(
                right: 0,
                bottom: 4,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: SizedBox(
                    height: 46,
                    width: 90,
                    child: FloatingActionButton.extended(
                      backgroundColor: Colors.green,
                      elevation: 8,
                      splashColor: Colors.amber,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        if (int.parse(_controller!.text) == widget.otp) {
//               print("The otp is Verified");
                        print(widget.bookingID);
                        Navigator.push(context, MaterialPageRoute(builder:(context)=>CollectCashPage(userID: widget.userID, bookingID: widget.bookingID, amount: amount, online: online,)));
                          // Get.off(
                          //   OrderDetails(
                          //     userID: widget.userID,
                          //     bookingID: widget.bookingID,
                          //   ),
                          // );

                        } else {
                          // print("Invalid OTP");
                          Get.showSnackbar(const GetSnackBar(
                            title: "Invalid OTP",
                            message: "Try it again",
                            isDismissible: true,
                            backgroundColor: Colors.black,
                            duration: Duration(seconds: 1),
                          ));
                        }
                        // _payment();
                        // Get.to(() => Packeges(
                        //   getFinalID: widget.getID,
                        //   gymName: widget.gymName,
                        //   gymLocation: widget.gymLocation,
                        // ));
                      },
                      label: Text(
                        "Verify",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//Container For TextField
// Container(
//   height: 45,
//   decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(8.0)),
//   child: Stack(
//     children: [
//       TextFormField(
//         controller: _controller,
//         decoration: InputDecoration(
//           border: InputBorder.none,
//           contentPadding:
//               const EdgeInsets.symmetric(horizontal: 10),
//           hintText: 'Enter OTP',
//           hintStyle: GoogleFonts.poppins(
//             fontWeight: FontWeight.w600,
//             fontSize: 14,
//             color: const Color(0xffC9C9C9),
//           ),
//         ),
//       ),
//       Positioned(
//         right: 20,
//         child: ElevatedButton(
//           onPressed: () async {
//             //Function for Verifying OTP
//
//             if (int.parse(_controller!.text) == widget.otp) {
//               print("The otp is Verified");
//               Get.off(
//                 OrderDetails(
//                   userID: widget.userID,
//                   bookingID: widget.bookingID,
//                 ),
//               );
//               await FirebaseFirestoreAPi()
//                   .acceptandUpdatebookingStatus(
//                 widget.bookingID,
//                 widget.userID,
//               );
//               await FirebaseFirestore.instance
//                   .collection('bookings')
//                   .doc(widget.userID)
//                   .collection('user_booking')
//                   .doc(widget.bookingID)
//               .update({
//                 "booking_accepted": true,
//               });
//             } else {
//               print("Invalid OTP");
//               Get.showSnackbar(const GetSnackBar(
//                 title: "Invalid OTP",
//                 message: "Try it again",
//                 isDismissible: true,
//                 backgroundColor: Colors.black,
//               ));
//             }
//           },
//           child:  Text(
//             'Verify',
//             style: GoogleFonts.poppins(
//               fontWeight: FontWeight.bold,
//               fontSize: 14
//             ),
//           ),
//           style: ButtonStyle(
//             backgroundColor: MaterialStateProperty.all(
//                 AppColors.bottomNaVBarTextColor),
//           ),
//         ),
//       )
//     ],
//   ),
// ),
