import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vyam_vandor/constants.dart';

class CompletedBookings extends StatelessWidget {
  const CompletedBookings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldBackgroundColor,
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('bookings')
              .where("booking_status", isEqualTo: "c")
              .where("vendorId", isEqualTo: "dipteshmandal555@gmail.com")
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text("Something went wrong");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            var document = snapshot.data!.docs;
            return document.isNotEmpty
                ? ListView.separated(
                    itemCount: document.length,
                    itemBuilder: (context, index) {
                      DateTime booking_date = DateTime.parse(
                          document[index]['booking_date'].toDate().toString());
                      DateTime starting_date = DateTime(booking_date.year,
                          booking_date.month, booking_date.day);
                      DateTime plan_end_duration = DateTime.parse(
                          document[index]['plan_end_duration']
                              .toDate()
                              .toString());
                      DateTime ending_date = DateTime(plan_end_duration.year,
                          plan_end_duration.month, plan_end_duration.day);

                      return Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: kDefaultPadding),
                        child: Container(
                          decoration: BoxDecoration(
                            color: kContainerColor,
                            borderRadius:
                                BorderRadius.circular(kContainerBorderRadius),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(kDefaultPadding - 1),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 1),
                                      child: Text(
                                        document[index]['user_name'],
                                        style: TextStyle(
                                          fontFamily: kFontFamily,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      '${months[starting_date.month - 1]} ${starting_date.day} - ${months[ending_date.month - 1]} ${ending_date.day}',
                                      style: TextStyle(
                                        fontFamily: kFontFamily,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      document[index]['booking_plan'],
                                      style: TextStyle(
                                        fontFamily: kFontFamily,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: kDurationColor,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      document[index]['booking_price']
                                          .toString(),
                                      style: TextStyle(
                                        fontFamily: kFontFamily,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const Divider(
                                      color: Colors.white,
                                      height: 31,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          height: 9,
                                          width: 9,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: kCompletedCircleColor,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          'Completed',
                                          style: TextStyle(
                                            fontFamily: kFontFamily,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: kDurationColor,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => Divider(
                      height: kDividerHeight,
                      color: kDividerColor,
                    ),
                  )
                : const Center(
                    child: Text(
                      "No Bookings",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  );
          }),
    );
  }
}
