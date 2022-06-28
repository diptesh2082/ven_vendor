import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vyam_vandor/Services/firebase_firestore_api.dart';

class NotificationApi {

  final Stream<QuerySnapshot> getnotification = FirebaseFirestore.instance   .collection("booking_notifications")
      .orderBy("time_stamp",descending: true)
      .where("vendor_id",isEqualTo: gymId)

      .snapshots();

  Future clearNotificationList() async {
    var remainderFirestore = FirebaseFirestore.instance
        .collection('user_details')
        .doc(gymId)
        .collection("booking_notifications");

    try {
      await remainderFirestore.get().then((value) {
        for (DocumentSnapshot ds in value.docs) {
          ds.reference.delete();
        }
      });
    } catch (e) {
      return null;
    }
  }
}
