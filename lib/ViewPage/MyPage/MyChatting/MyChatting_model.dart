import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyChattingModel {
  Future<QuerySnapshot> getMyChattingData() async {
    String? userUID = FirebaseAuth.instance.currentUser!.uid;
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(userUID)
        .collection('Chattings')
        .get();

    return snapshot;
  }

  Future<void> deleteChattingData({required String docName}) async {
    String? userUID = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(userUID)
        .collection('Chattings')
        .doc(docName)
        .delete();
  }
}
