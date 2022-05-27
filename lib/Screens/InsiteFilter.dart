import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vyam_vandor/Screens/sales/Sales.dart';

import '../Services/firebase_firestore_api.dart';
import '../controllers/gym_controller.dart';
import '../sales/sales_main_page.dart';
import 'Tabs/Insights/payment_history.dart';
import 'review.dart';

class InsitesFilter extends StatelessWidget {
  InsitesFilter({Key? key, required this.days}) : super(key: key);
  final int? days;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12),
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Column(
                    children: [
                      if (days == 7)
                        Obx(
                          () => GestureDetector(
                            onTap: () {
                              Get.to(() => const Sales());
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: HexColor("292F3D"),
                              ),
                              width: size.width * 0.45,
                              height: 290,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            "Sales",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          const Spacer(),
                                          // const SizedBox(
                                          //   width: 240,
                                          // ),
                                          // Image.asset(
                                          //     "Assets/trend-down.png"),
                                          const SizedBox(
                                            width: 2,
                                          ),
                                          Text(
                                            "${Get.find<BookingController>().booking.value}", //last ₹
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Total sales",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 42,
                                      ),
                                      Obx(
                                        () => Text(
                                          "₹${(Get.find<BookingController>().on_line_7.value + Get.find<BookingController>().off_line_7.value)}", // DATABASE CALLLING FOR TOTAL SALES VALUE
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 35,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 54,
                                      ),
                                      Image.asset(
                                        "Assets/Vector 7.png",
                                        width: size.width * 0.4,
                                        fit: BoxFit.fitWidth,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      if (days == 30)
                        Obx(
                          () => GestureDetector(
                            onTap: () {
                              Get.to(() => const Sales());
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: HexColor("292F3D"),
                              ),
                              width: size.width * 0.45,
                              height: 290,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            "Sales",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          const Spacer(),
                                          // const SizedBox(
                                          //   width: 240,
                                          // ),
                                          // Image.asset(
                                          //     "Assets/trend-down.png"),
                                          const SizedBox(
                                            width: 2,
                                          ),
                                          Text(
                                            "${Get.find<BookingController>().booking.value}", //Last ₹
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Total sales",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 42,
                                      ),
                                      Obx(
                                        () => Text(
                                          "₹${(Get.find<BookingController>().on_line_month.value + Get.find<BookingController>().off_line_month.value)}", // DATABASE CALLLING FOR TOTAL SALES VALUE
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 35,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 54,
                                      ),
                                      Image.asset(
                                        "Assets/Vector 7.png",
                                        width: size.width * 0.4,
                                        fit: BoxFit.fitWidth,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      if (days == 15)
                        Obx(
                          () => GestureDetector(
                            onTap: () {
                              Get.to(() => const Sales());
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: HexColor("292F3D"),
                              ),
                              width: size.width * 0.45,
                              height: 290,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            "Sales",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          const Spacer(),
                                          // const SizedBox(
                                          //   width: 240,
                                          // ),
                                          // Image.asset(
                                          //     "Assets/trend-down.png"),
                                          const SizedBox(
                                            width: 2,
                                          ),
                                          Text(
                                            "${Get.find<BookingController>().booking.value}", //Last ₹
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Total sales",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 42,
                                      ),
                                      Obx(
                                        () => Text(
                                          "₹${(Get.find<BookingController>().on_line_month.value + Get.find<BookingController>().off_line_month.value)}", // DATABASE CALLLING FOR TOTAL SALES VALUE
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 35,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 54,
                                      ),
                                      Image.asset(
                                        "Assets/Vector 7.png",
                                        width: size.width * 0.4,
                                        fit: BoxFit.fitWidth,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const Spacer(),
                  // const SizedBox(
                  //   width: 10,
                  // ),
                  Column(
                    children: [
                      if (days == 7)
                        InkWell(
                          onTap: () {
                            Get.to(() => const TotalBookings());
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: HexColor("292F3D"),
                            ),
                            width: size.width * 0.45,
                            height: 135,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          "Total bookings",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        const Spacer(),
                                        // const SizedBox(
                                        //   width: 220,
                                        // ),
                                        Image.asset("Assets/trend-up.png"),
                                        const SizedBox(
                                          width: 2,
                                        ),
                                        const Text(
                                          "8",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    Obx(
                                      () => Text(
                                        Get.find<BookingController>()
                                            .booking_7
                                            .value
                                            .toString(), //DATABASE CALLING FOR TOTAL BOOKING VALUE
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 35,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      if (days == 15)
                        InkWell(
                          onTap: () {
                            Get.to(() => const TotalBookings());
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: HexColor("292F3D"),
                            ),
                            width: size.width * 0.45,
                            height: 135,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          "Total bookings",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        const Spacer(),
                                        // const SizedBox(
                                        //   width: 220,
                                        // ),
                                        Image.asset("Assets/trend-up.png"),
                                        const SizedBox(
                                          width: 2,
                                        ),
                                        const Text(
                                          "8",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    Obx(
                                      () => Text(
                                        Get.find<BookingController>()
                                            .booking_15
                                            .value
                                            .toString(), //DATABASE CALLING FOR TOTAL BOOKING VALUE
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 35,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      if (days == 30)
                        InkWell(
                          onTap: () {
                            Get.to(() => const TotalBookings());
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: HexColor("292F3D"),
                            ),
                            width: size.width * 0.45,
                            height: 135,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          "Total bookings",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        const Spacer(),
                                        // const SizedBox(
                                        //   width: 220,
                                        // ),
                                        Image.asset("Assets/trend-up.png"),
                                        const SizedBox(
                                          width: 2,
                                        ),
                                        const Text(
                                          "8",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    Obx(
                                      () => Text(
                                        Get.find<BookingController>()
                                            .booking_30
                                            .value
                                            .toString(), //DATABASE CALLING FOR TOTAL BOOKING VALUE
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 35,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      const SizedBox(
                        height: 20,
                      ),
                      ReviewBox(
                        size: size,
                        days: days!,
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReviewBox extends StatelessWidget {
  const ReviewBox({
    Key? key,
    required this.size,
    required this.days,
  }) : super(key: key);

  final Size size;
  final int days;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Reviews")
            .where("gym_id", isEqualTo: gymId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Container(
              child: Center(child: Text("No reviews yet")),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: HexColor("292F3D"),
              ),
              width: size.width * 0.45,
              height: 135,
            );
          }
          var reviews = snapshot.data!.docs.length;
          return InkWell(
            onTap: () {
              Get.to(
                () => Review(),
                duration: Duration(
                  milliseconds: 500,
                ),
                // curve: Curve.flipped()
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: HexColor("292F3D"),
              ),
              width: size.width * 0.45,
              height: 135,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Reviews",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 21,
                      ),
                      Text(
                        "${reviews}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
