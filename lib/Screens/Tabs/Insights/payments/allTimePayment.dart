import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vyam_vandor/Services/firebase_firestore_api.dart';

class AllTimePay extends StatelessWidget {
  const AllTimePay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 95,
                child:  StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance.collection("product_details").doc(gymId).snapshots(),
                    builder: (context, snapshot) {
                      var details=snapshot.data;
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 27, left: 27),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Due payment',
                                  style: TextStyle(
                                      color: Colors.black38,
                                      fontFamily: "Poppins",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                // SizedBox(height: 5),
                                Text(
                                  'For January',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "Poppins",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            const Spacer(),
                             Text(
                              '₹ ${details!.get("payment_due")}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Poppins",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                ),
              ),
              SizedBox(
                height: 5,
              ),

              SizedBox(
                height: 120,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection("payment")
                      .where("gym_id",isEqualTo: gymId)
                      .snapshots(),
                  builder: (context,AsyncSnapshot snapshot) {
                    if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (snapshot.data == null) {
                      return Center(child: const Text("No Upcoming Bookings"));
                    }

                    var doc = snapshot.data.docs;
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: doc.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            minVerticalPadding: 12,
                            leading: Container(
                              height: 50,
                              width: 50,
                              padding: const EdgeInsets.all(0),
                              child: Image.asset(
                                "Assets/Group87.png",
                                fit: BoxFit.cover,
                              ),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            title: Column(
                              children: const [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Received from",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                      fontSize: 11,
                                      fontFamily: "Poppins",
                                    ),
                                  ),
                                ),
                                // SizedBox(
                                //   height: 5,
                                // ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Vyam",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Poppins",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                // SizedBox(
                                //   height: 5,
                                // ),
                              ],
                            ),
                            subtitle:  Text(
                              DateFormat("dd, MMM, yyyy").format(doc[index]["timestamp"].toDate()),
                              style: TextStyle(
                                  color: Colors.black38,
                                  fontFamily: "Poppins",
                                  fontSize: 9,
                                  fontWeight: FontWeight.w600),
                            ),
                            trailing: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children:  [
                                Text(
                                  "₹ ${doc[index]["amount"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontFamily: "Poppins",
                                  ),
                                ),
                                // SizedBox(
                                //   height: 10,
                                // ),
                                Text(
                                  "Credited to bank account",
                                  style: TextStyle(
                                      color: Colors.black38,
                                      fontFamily: "Poppins",
                                      fontSize: 9,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            selected: true,
                            onTap: () {},
                          );
                        });
                  }
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
