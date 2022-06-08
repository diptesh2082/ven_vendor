import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:vyam_vandor/Screens/home__screen.dart';
import '../app_colors.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({
    Key? key,
    this.userID,
    this.bookingID,
    this.chinki=false,
    this.imageUrl = "Assets/Images/rect.png",
  }) : super(key: key);
  final bool chinki;
  final String? userID;
  final String? bookingID;
  final String? imageUrl;

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {

  makeSure2()async{
    if (widget.chinki==true)
    showDialog(context: context,
      builder:(context)=> AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16))),
        content: SizedBox(
          height: 170,
          width: 280,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "Assets/Images/S.gif",
                height: 70,
                width: 70,
              ),
              // Text(
              //   "Proceed payment in cash ?",
              //   style: GoogleFonts.poppins(
              //       fontSize: 15,
              //       fontWeight: FontWeight.bold
              //   ),
              // ),

              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 3, right: 3, top: 2, bottom: 2),
                      child: Center(
                        child: Text(
                          "Booking activated !",
                          style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: HexColor("030202")),
                        ),
                      ),
                    ),
                    // Image.asset("assets/icons/icons8-approval.gif",
                    //   height: 70,
                    //   width: 70,
                    // ),

                    const SizedBox(width: 15),
                    Container(
                        height: 38,
                        width: 90,
                        decoration: BoxDecoration(
                            color: HexColor("27AE60"),
                            borderRadius: BorderRadius.circular(8)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 3, right: 3, top: 2, bottom: 2),
                          child: Center(
                            child: Text(
                              "Proceed",
                              style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: HexColor("030105")),
                            ),
                          ),
                        )),
                  ]),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      if (widget.chinki==true)
      showDialog(context: context,
        builder:(context)=> AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16))),
          content: SizedBox(
            height: 220,
            width: 280,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    "Assets/Images/S.gif",
                    height: 155,
                    width: 200,
                  ),
                ),
                Text(
                  "Booking activated !",
                  style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: HexColor("030202")),
                ),
              ],
            ),
          ),
        ),
      );
    });


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        if(widget.chinki){
          Get.offAll(()=>HomeScreen());
        }

        return true;
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          title: const Text(
            'Order Details',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('bookings')
                      // .where("userId",isEqualTo: widget.userID)
                      .doc(widget.bookingID)
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return Container();
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return Column(
                      children: [
                        //Container 1 for Booking Summary
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Column(
                              children: [
                                StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection('product_details')
                                        .doc(FirebaseAuth
                                            .instance.currentUser!.email)
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

                                      return FittedBox(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 169,
                                                width: 187,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(15)),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  child: CachedNetworkImage(
                                                    imageUrl: snapshot.data!.get(
                                                        'gym_details')["image"],
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 15.0,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceAround,
                                                children: [
                                                  Material(
                                                    elevation: 3,
                                                    borderRadius: BorderRadius.circular(5),
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(left: 8.0,right: 8),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            'Booking ID:- ',
                                                            style: GoogleFonts.poppins(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight.w500,
                                                            ),
                                                          ),
                                                          Text(
                                                            '${snapshot.data!.get('id')}',
                                                            style: GoogleFonts.poppins(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight.w600,
                                                              color: Colors.amberAccent
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10.0,
                                                  ),
                                                  Text(
                                                    '${snapshot.data!.get('gym_details')["name"]}',
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w700,
                                                    ),
                                                  ),

                                                  const SizedBox(
                                                    height: 6.0,
                                                  ),
                                                  Text(
                                                    DateFormat("dd,MMMM,yyyy")
                                                        .format(snapshot.data!
                                                            .get('order_date')
                                                            .toDate()),
                                                    // snapshot.data!.get('booking_date').toString(),
                                                    // snapshot3.data
                                                    //     .get('gym_details')["branch"],
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    child: SizedBox(
                                                      width: MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.5,
                                                      child: Text(
                                                        snapshot3.data
                                                            .get('address'),
                                                        overflow:
                                                            TextOverflow.ellipsis,
                                                        maxLines: 2,
                                                        style: GoogleFonts.poppins(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  if(snapshot.data!.get('booking_status').toLowerCase()=="upcoming")
                                                  Row(
                                                    children: [
                                                      CircleAvatar(
                                                        radius: 5,
                                                        backgroundColor:
                                                            Colors.amber,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        ' ${snapshot.data!.get('booking_status')}',
                                                        style: GoogleFonts.poppins(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  if(snapshot.data!.get('booking_status').toLowerCase()=="active")
                                                    Row(
                                                      children: [
                                                        CircleAvatar(
                                                          radius: 5,
                                                          backgroundColor:
                                                          snapshot.data!.get('plan_end_duration').toDate().difference(DateTime.now()).inDays >= 0 ? Colors.green:Colors.amber,
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          ' ${snapshot.data!.get('plan_end_duration').toDate().difference(DateTime.now()).inDays >= 0 ?snapshot.data!.get('booking_status'):"Completed"}',
                                                          style: GoogleFonts.poppins(
                                                            fontSize: 14,
                                                            fontWeight:
                                                            FontWeight.w600,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  if(snapshot.data!.get('booking_status').toLowerCase()=="completed")
                                                    Row(
                                                      children: [
                                                        CircleAvatar(
                                                          radius: 5,
                                                          backgroundColor:
                                                          Colors.amberAccent,
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          ' ${snapshot.data!.get('booking_status')}',
                                                          style: GoogleFonts.poppins(
                                                            fontSize: 14,
                                                            fontWeight:
                                                            FontWeight.w600,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                                const SizedBox(
                                  height: 18.0,
                                ),
                                const Divider(
                                  height: 2,
                                  color: Color(0xffE2E2E2),
                                ),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Workout',
                                            style: GoogleFonts.poppins(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.green),
                                          ),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          Text(
                                            '${snapshot.data!.get('booking_plan')}',
                                            style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 7.0,
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
                                            height: 7.0,
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
                                            '${snapshot.data.get('package_type')}',
                                            style: GoogleFonts.poppins(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.green),
                                          ),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          Text(
                                            '${snapshot.data.get('totalDays').toString()} days',
                                            style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 7.0,
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
                                            height: 7.0,
                                          ),
                                          Text(
                                            DateFormat(DateFormat.YEAR_MONTH_DAY)
                                                .format(snapshot.data
                                                    .get('plan_end_duration')
                                                    .toDate()),
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  height: 1,
                                  thickness: 1,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Total Amount',
                                        style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.green),
                                      ),
                                      Spacer(),
                                      Text(
                                        '₹ ${snapshot.data.get('total_price')}',
                                        style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.green),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        //Container For TextField
                        //Container For payment
                        const SizedBox(
                          height: 10.0,
                        ),

                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('user_details')
                                  .doc(widget.userID)
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot2) {
                                if (snapshot2.data == null) {
                                  return Container();
                                }
                                if (snapshot2.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }

                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Customers Details',
                                        style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: const Color(0xff3A3A3A)),
                                      ),
                                      const SizedBox(
                                        height: 7.0,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Username: ',
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            ' ${snapshot2.data.get("name")}',
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Phone Number: ',
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            ' ${snapshot2.data.get('userId')}',
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Payment Method : ',
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Material(
                                            color: Colors.green,
                                            elevation: 3,
                                            borderRadius: BorderRadius.circular(7),
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 3.0,right: 5),
                                              child: Text(
                                                ' ${snapshot.data.get('payment_method')}',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        )
                      ],
                    );
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
