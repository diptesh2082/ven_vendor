// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vyam_vandor/Screens/Tabs/Insights/insights.dart';
import 'package:vyam_vandor/Services/firebase_firestore_api.dart';
import 'package:vyam_vandor/controllers/gym_controller.dart';
import 'package:vyam_vandor/sales/sales_main_page.dart';

import '../../../review.dart';
import '../../../sales/Sales.dart';
import '../payment_history.dart';
// import 'package:vyam/Insights/payment_history.dart';

class AllTime extends StatefulWidget {
  const AllTime({Key? key}) : super(key: key);

  @override
  AllTimeState createState() => AllTimeState();

  static void getDocumentsLength() {}
}

class AllTimeState extends State<AllTime> {
  final _auth = FirebaseAuth.instance;
  String totalBooking = '0';
  // String totalSales = '0';
  BookingController bookingController = Get.find<BookingController>();
  getDocumentsLength(String gymd) async {
    try{
      await FirebaseFirestore.instance
          .collection('bookings')
          .where('vendorId', isEqualTo: gymd.toString())
          .where('booking_status',
          whereIn: ['upcoming', 'active', 'completed'])
          .snapshots().listen((snapshot) {
        if (snapshot.docs.isNotEmpty) {
          bookingController.booking.value=snapshot.docs.length;
          double d=0.0;
          var off_line_all=0.0;
          var on_line_all=0.0;
          var off_line_7=0.0;
          var on_line_7=0.0;
          var off_line_month=0.0;
          var on_line_month=0.0;
          var booking_7=0.0;
          var booking_15=0.0;
          var booking_30=0.0;
          snapshot.docs.forEach((element) {

            d = d + double.parse(element["booking_price"].toString());
            if (element["payment_method"]=="offline"){
              off_line_all=off_line_all+double.parse(element["booking_price"].toString());

            }
            if( DateTime.now().difference(element["booking_date"].toDate()).inDays<=7  && element["payment_method"]=="offline"){
              off_line_7=off_line_7+double.parse(element["booking_price"].toString());
            }
            if( DateTime.now().difference(element["booking_date"].toDate()).inDays<=30  && element["payment_method"]=="offline"){
              off_line_month=off_line_month+double.parse(element["booking_price"].toString());
            }
            if (element["payment_method"]=="online"){
              on_line_all=on_line_all+double.parse(element["booking_price"].toString());
            }
            if (element["payment_method"]=="online" && DateTime.now().difference(element["booking_date"].toDate()).inDays<=7  ){
              on_line_7=on_line_7+double.parse(element["booking_price"].toString());
            }
            if (element["payment_method"]=="online" && DateTime.now().difference(element["booking_date"].toDate()).inDays<=30  ){
              on_line_month=on_line_month+double.parse(element["booking_price"].toString());
            }
            if( DateTime.now().difference(element["booking_date"].toDate()).inDays<=7 ){
              booking_7=booking_7+1.0;
            }
            if( DateTime.now().difference(element["booking_date"].toDate()).inDays<=15 ){
              booking_15=booking_15+1.0;
            }
            if( DateTime.now().difference(element["booking_date"].toDate()).inDays<=15 ){
              booking_30=booking_30+1.0;
            }
            bookingController.total_sales.value=d.toInt();
            bookingController.off_line_all.value=off_line_all.toInt();
            bookingController.on_line_all.value=on_line_all.toInt();
            bookingController.off_line_7.value=off_line_7.toInt();
            bookingController.on_line_7.value=on_line_7.toInt();
            bookingController.off_line_month.value=off_line_month.toInt();
            bookingController.on_line_month.value=on_line_month.toInt();
            bookingController.booking_7.value=booking_7.toInt();
            bookingController.booking_15.value=booking_15.toInt();
            bookingController.booking_30.value=booking_30.toInt();
          }

          );

          // setState(() {
          //   totalBooking = snapshot.docs.length.toString();
          // });
        }
        else if (snapshot.docs.isEmpty) {
          // setState(() {
          totalBooking = 0.toString();
          bookingController.total_sales.value=0;
          bookingController.off_line_all.value=0;
          bookingController.on_line_all.value=0;
          bookingController.off_line_7.value=0;
          bookingController.on_line_7.value=0;
          bookingController.off_line_month.value=0;
          bookingController.on_line_month.value=0;
          bookingController.booking_7.value=0;
          bookingController.booking_15.value=0;
          bookingController.booking_30.value=0;
          bookingController.booking.value=0;
          // });
        }
      });
    }catch(e){
      bookingController.booking.value=0;
      bookingController.total_sales.value=0;
      bookingController.off_line_all.value=0;
      bookingController.on_line_all.value=0;
      bookingController.off_line_7.value=0;
      bookingController.on_line_7.value=0;
      bookingController.off_line_month.value=0;
      bookingController.on_line_month.value=0;
      bookingController.booking_7.value=0;
      bookingController.booking_15.value=0;
      bookingController.booking_30.value=0;
    }

   // await FirebaseFirestore.instance
   //      .collection('bookings')
   //      .where('vendorId', isEqualTo: gymId.toString())
   //      .where('booking_status',
   //     whereIn: ['upcoming', 'active', 'completed']).snapshots()
   //  .listen((snapshot) {
   //    if(snapshot.exists){
   //
   //    }
   //   setState(() {
   //     totalBooking = snapshot.docs.length.toString();
   //   }
   //  });


    // );
    //
    // print(totalBooking);
  }

  @override
  void initState() {
    print(_auth.currentUser!.email.toString());
    super.initState();
    getDocumentsLength(gymId);
  }
  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   bookingController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // getDocumentsLength();
    // InsightsTab().createState();
    // initState();
    return Scaffold(
      body:
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  SizedBox(
                    width: size.width,
                    height: 500,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Obx(
                        ()=> GestureDetector(
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              // const Text(
                                              //   "Sales",
                                              //   style: TextStyle(
                                              //     color: Colors.white,
                                              //   ),
                                              // ),
                                              // const Spacer(),
                                              // // const SizedBox(
                                              // //   width: 240,
                                              // // ),
                                              // // Image.asset(
                                              // //     "Assets/trend-down.png"),
                                              // const SizedBox(
                                              //   width: 2,
                                              // ),
                                              //  Text(
                                              //   "${bookingController.booking.value}",
                                              //   style: TextStyle(
                                              //     color: Colors.white,
                                              //   ),
                                              // ),
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
                                            height: 50,
                                          ),
                                          Text(
                                            "₹${bookingController.total_sales.value.toString()}", // DATABASE CALLLING FOR TOTAL SALES VALUE
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 35,
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
                            const Spacer(),
                            // const SizedBox(
                            //   width: 10,
                            // ),
                            Column(
                              children: [
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
                                                // Image.asset(
                                                //     "Assets/trend-up.png"),
                                                // const SizedBox(
                                                //   width: 2,
                                                // ),
                                                // const Text(
                                                //   "8",
                                                //   style: TextStyle(
                                                //     color: Colors.white,
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 24,
                                            ),
                                            Obx(
                                                ()=> Text(
                                                bookingController.booking.value.toString(), //DATABASE CALLING FOR TOTAL BOOKING VALUE
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
                                ReviewsBox(size: size)
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        StreamBuilder<DocumentSnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('product_details')
                                .doc(gymId.toString())
                                .snapshots(),
                            builder: (context,AsyncSnapshot snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              if (snapshot.data == null) {
                                return Container();
                              }
                              // int viewCount=snapshot.data!.get("view_count");
                              return Padding(
                                padding: const EdgeInsets.only(
                                    top: 0.0, left: 2.0, right: 2.0),
                                child: Card(
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0)),
                                    child: SizedBox(
                                      height: 63,
                                      child: Center(
                                        child: ListTile(
                                            title:  Text(
                                              '${snapshot.data.get("view_count")??""} Views',
                                              style: GoogleFonts.poppins(
                                                  color: Colors.black54,
                                                  // fontFamily: 'PoppinsSemiBold',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            trailing: ImageIcon(
                                              AssetImage(
                                                "Assets/Images/Show.png",
                                              ),
                                              size: 30,
                                            )
                                        ),
                                      ),
                                    )
                                ),
                              );
                            }
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                          height: 63,
                          child: GestureDetector(
                            onTap: () => Get.to(const PaymentHistory()),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  children: const [
                                    Text(
                                      'View payment history',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontFamily: "Poppins",
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      size: 18,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )

    );
  }
}

class ReviewsBox extends StatelessWidget {
  const ReviewsBox({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("Reviews")
        .where("gym_id",isEqualTo: gymId).snapshots(),
      builder: (context, snapshot) {
        if(snapshot.connectionState==ConnectionState.waiting){
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: HexColor("292F3D"),
            ),
            width: size.width * 0.45,
            height: 135,
          );
        }
        if(snapshot.hasError){
          return Container(

              child: Center(child: Text(
                "No reviews yet"
              )),
              decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        color: HexColor("292F3D"),
        ),
        width: size.width * 0.45,
        height: 135,
          );
        }
        var reviews=snapshot.data!.docs.length;
        Get.find<BookingController>().review_number.value=snapshot.data!.docs.length;
        return InkWell(
          onTap: (){
            Get.to(()=>Review(),duration: Duration(
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
                  children:  [
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
      }
    );
  }
}
