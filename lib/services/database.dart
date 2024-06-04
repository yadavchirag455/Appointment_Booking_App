import 'package:cloud_firestore/cloud_firestore.dart';

class Databasemethods {
  Future addUserDetails(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .set(userInfoMap);
  }

  Future addUserBooking(Map<String, dynamic> usersBookingInfoMap) async {
    return await FirebaseFirestore.instance
        .collection("Booking")
        .add(usersBookingInfoMap);
  }

  Future<Stream<QuerySnapshot>> getBookingDetails() async {
    return await FirebaseFirestore.instance.collection("Booking").snapshots();
  }

  Future deletUserBooking(String id) async {
    return await FirebaseFirestore.instance
        .collection("Booking")
        .doc(id)
        .delete();
  }
}
