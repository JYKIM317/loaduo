import 'package:cloud_firestore/cloud_firestore.dart';

class MyPageModel {
  Future<dynamic> getUserData(String uid) async {
    final myDB =
        await FirebaseFirestore.instance.collection('Users').doc(uid).get();
    return myDB;
  }
}
