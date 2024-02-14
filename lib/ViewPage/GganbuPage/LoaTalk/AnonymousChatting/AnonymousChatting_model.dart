import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AnonymousChattingModel {
  Future<void> saveMessageData({
    required String address,
    required String messageId,
    required Map<String, dynamic> message,
  }) async {
    final chatAddress = FirebaseDatabase.instance.ref('$address/$messageId');
    await chatAddress.set(message);
  }

  Future<void> updateMessageTime({
    required String address,
    required String lastMessageTime,
  }) async {
    final chatAddress = FirebaseDatabase.instance.ref(address);
    await chatAddress.update({'lastMessageTime': lastMessageTime});
  }

  Future<Map<dynamic, dynamic>?> getThisChatData(
      {required String address}) async {
    final chatAddress = FirebaseDatabase.instance.ref(address);
    DataSnapshot? chatSnapshot = await chatAddress.get();
    Map<dynamic, dynamic>? addressData =
        chatSnapshot.value as Map<dynamic, dynamic>?;
    addressData?.remove('lastMessageTime');
    return addressData;
  }

  Future<bool> moveThisChatData({
    required String me,
    required String otherPerson,
    required Map<dynamic, dynamic> data,
  }) async {
    late bool result;
    final chatAddress =
        FirebaseDatabase.instance.ref('Chatting/Gganbu/$otherPerson/$me');
    DataSnapshot? chatSnapshot = await chatAddress.get();
    Map<dynamic, dynamic>? addressData =
        chatSnapshot.value as Map<dynamic, dynamic>?;
    if (addressData == null) {
      result = true;
      await chatAddress.set(data);
    } else {
      result = false;
    }

    return result;
  }

  Future<void> addChatAddressData({
    required String me,
    required String otherPerson,
  }) async {
    DateTime now = DateTime.now();
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(me)
        .collection('Chattings')
        .doc('Chatting Gganbu $otherPerson $me')
        .set({
      'resentMessageTime': now,
      'resentCheckTime': now,
    });
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(otherPerson)
        .collection('Chattings')
        .doc('Chatting Gganbu $otherPerson $me')
        .set({
      'resentMessageTime': now,
      'resentCheckTime': now,
    });
  }
}
