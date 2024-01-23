import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class GganbuPostModel {
  Future<DocumentSnapshot> getPostDoc({required String address}) async {
    final postData = await FirebaseFirestore.instance
        .collection('RegisteredPost')
        .doc('FindPages')
        .collection('GganbuPost')
        .doc(address)
        .get();

    return postData;
  }

  Future<void> updatePost({
    required String address,
    required Map<String, dynamic> postData,
  }) async {
    await FirebaseFirestore.instance
        .collection('RegisteredPost')
        .doc('FindPages')
        .collection('GganbuPost')
        .doc(address)
        .update(postData);
  }

  Future<void> removePost({
    required String address,
  }) async {
    await FirebaseFirestore.instance
        .collection('RegisteredPost')
        .doc('FindPages')
        .collection('GganbuPost')
        .doc(address)
        .delete()
        .then((_) async {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(address)
          .collection('MyPosts')
          .doc('GganbuPost')
          .delete()
          .then((_) async {
        await FirebaseDatabase.instance
            .ref('Chatting/Gganbu/$address')
            .remove();
      });
    });
  }

  Future<bool> getChattingExist({
    required String address,
    required String uid,
  }) async {
    late bool exist;
    final conversation = await FirebaseDatabase.instance
        .ref('Chatting/Gganbu/$address/$uid')
        .get();
    exist = conversation.exists;
    return exist;
  }

  Future<void> setChattingAddress({
    required String address,
    required String uid,
    required Map<String, dynamic> info,
  }) async {
    await FirebaseDatabase.instance.ref('Chatting/Gganbu/$address/$uid').set({
      'Messages': {},
      'info': info,
    }).then((_) async {
      DateTime now = DateTime.now();
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(uid)
          .collection('Chattings')
          .doc('Chatting Gganbu $address $uid')
          .set({
        'resentMessageTime': now,
        'resentCheckTime': now,
      });
    });
  }
}
