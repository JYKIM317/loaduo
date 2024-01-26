import 'package:cloud_firestore/cloud_firestore.dart';

class BlockPageModel {
  Future<void> removeBlockUserData({required String uid}) async {
    await FirebaseFirestore.instance.collection('BlockUsers').doc(uid).delete();
  }
}
