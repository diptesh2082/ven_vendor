import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:vyam_vandor/Services/profileicon_icons.dart';
import 'package:vyam_vandor/controllers/gym_controller.dart';
import 'package:vyam_vandor/widgets/booking_card.dart';

import '../Screens/order_details_screen.dart';
import '../Services/firebase_firestore_api.dart';
import 'active_booking.dart';

class SearchIt extends StatefulWidget {
  const SearchIt({Key? key}) : super(key: key);

  @override
  State<SearchIt> createState() => _SearchItState();
}

class _SearchItState extends State<SearchIt> {
  TextEditingController searchController = TextEditingController();
  String searchGymName = '';
  FocusNode _node = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * .92,
              height: 51,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Colors.white,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: TextField(
                  focusNode: _node,
                  autofocus: false,
                  textAlignVertical: TextAlignVertical.bottom,
                  onSubmitted: (value) async {
                    FocusScope.of(context).unfocus();
                  },
                  controller: searchController,
                  onChanged: (value) {
                    if (value.length == 0) {
                      _node.canRequestFocus = false;
                      // FocusScope.of(context).unfocus();
                    }
                    if (mounted) {
                      setState(() {
                        searchGymName = value.toString();
                        Get.find<SearchCon>().search.value = value.toString();
                      });
                    }
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Profileicon.search),
                    hintText: 'Search',
                    hintStyle: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.w500),
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.grey[100],
              child: Column(
                children: [
                  if (searchGymName.isNotEmpty)
                    Container(
                      width: MediaQuery.of(context).size.width,
                      // height: (searchGymName.length<=2)?500:null,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey[100],
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 25,
                          ),
                          buildGymBox(),
                          // const SizedBox(
                          //   height: 500,
                          // )
                        ],
                      ),
                    ),
                  if (_node.hasFocus)
                    Container(
                      color: Colors.grey[100],
                      height: 4000,
                    )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  SizedBox buildGymBox() {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * .94,
      height: size.height,
      child: SingleChildScrollView(
          child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('bookings')
            .where("vendorId", isEqualTo: gymId)
            .where('booking_status', whereIn: ["upcoming", "active"])
            .orderBy("order_date", descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snap.data == null) {
            return const Text("No Upcoming Bookings");
          }

          var doc = snap.data.docs;

          if (searchGymName.length > 0) {
            doc = doc.where((element) {
              return element
                      .get('user_name')
                      .toString()
                      .toLowerCase()
                      .contains(searchGymName.toString()) ||
                  element
                      .get('id')
                      .toString()
                      .toLowerCase()
                      .contains(searchGymName.toString());
            }).toList();
          }
          // if (searchGymName.length > 0) {
          //   doc = doc.where((element) {
          //     return element
          //         .get('id')
          //         .toString()
          //         .toLowerCase()
          //         .contains(searchGymName.toString());
          //   }).toList();
          // }
          return Column(
            children: [
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: doc.length,
                itemBuilder: (context, index) {
                  // print("device token ${device_token}");
                  // print(
                  //     "gfhfhgjfdkdyuuyuyuyuyuyuyuyuyuyuyuyuyuyuyuyuyuyuyuyuyuy ${gymId}");
                  // print(
                  //     "gfhfhgjfdkdyuuyuyuyuyuyuyuyuyuyuyuyuyuyuyuyuyuyuyuyuyuy ${gymId}");
                  // print(
                  //     "gfhfhgjfdkdyuuyuyuyuyuyuyuyuyuyuyuyuyuyuyuyuyuyuyuyuyuy ${gymId}");
                  /// UPCOMING BOOKING CARD
                  if (doc[index]['booking_status'] == 'upcoming'
                      // && doc[index]["vendorId"]==gymId.toString()
                      )
                  // if(doc[index][])
                  {
                    return BookingCard(
                      userID: doc[index]['userId'] ?? "",
                      userName: doc[index]['user_name'] ?? "",
                      bookingID: doc[index]['booking_id'] ?? "",
                      bookingPlan: doc[index]['booking_plan'] ?? "",
                      bookingPrice: doc[index]['booking_price'].toString(),
                      // docs: doc[index],
                      bookingdate: DateFormat(DateFormat.YEAR_MONTH_DAY)
                          .format(doc[index]['booking_date'].toDate()),
                      otp: int.parse(doc[index]['otp_pass']),
                      id: doc[index]['id'].toString(),
                    );
                  }
                  if (doc[index]['booking_status'] == 'active'
                      // && doc[index]["vendorId"]==gymId.toString()
                      )
                  // if(doc[index][])
                  {
                    return GestureDetector(
                      onTap: () async {
                        // print("wewe");
                        await OrderDetails(
                          userID: doc[index]['userId'],
                          bookingID: doc[index]['booking_id'],
                          imageUrl: doc[index]["gym_details"]["images"],
                        );
                      },
                      child: ActiveBookingCard(
                        userID: doc[index]['userId'] ?? "",
                        userName: doc[index]['user_name'] ?? "",
                        bookingID: doc[index]['booking_id'] ?? "",
                        bookingPlan: doc[index]['booking_plan'] ?? "",
                        bookingPrice:
                            double.parse(doc[index]['grand_total'].toString()),
                        bookingdate: doc[index]['booking_date'].toDate(),
                        //   .format(
                        // doc[index]['booking_date']
                        //     .toDate(),
                        // ),
                        end_date: doc[index]['plan_end_duration'].toDate(),

                        id: doc[index]['id'].toString(),
                      ),
                    );
                  }
                  return Container(
                    color: Colors.grey[100],
                  );
                },
              ),
              SizedBox(
                height: 400,
              )
            ],
          );
        },
      )),
    );
  }
}
