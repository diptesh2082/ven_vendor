import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseCollectionAndDocsApi {
  final _firbaseFirestore = FirebaseFirestore.instance;

// Streams For Products Details

  get bookingsDetails => _firbaseFirestore
      .collection('products_details')
      .doc("ompranaykumar@gmail.com")
      .collection("gym")
      .snapshots();

  get gymDetails => _firbaseFirestore
      .collection("product_details")
      .doc("mahtab5752@gmail.com")
      .get();

  get bookingStream => _firbaseFirestore
      .collection('bookings')
      .where("vendorId", isEqualTo: "T@gmail.com")
      .snapshots();
}
