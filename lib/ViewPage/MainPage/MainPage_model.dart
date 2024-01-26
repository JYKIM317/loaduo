import 'package:cloud_firestore/cloud_firestore.dart';

class MainPageModle {
  Future<DocumentSnapshot> getBlockUserData({required String uid}) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('BlockUsers')
        .doc(uid)
        .get();

    return snapshot;
  }
}
