import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChattingPageModel {
  Future<void> saveMessageData({
    required String address,
    required String messageId,
    required Map<String, dynamic> message,
  }) async {
    final chatAddress = FirebaseDatabase.instance.ref('$address/$messageId');
    await chatAddress.set(message);
  }

  Future<void> updateRecentMessage({
    required String uid,
    required String address,
    required DateTime sendTime,
  }) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('Chattings')
        .doc(address)
        .update({
      'resentMessageTime': sendTime,
    });
  }
}
