import 'package:cloud_firestore/cloud_firestore.dart';

class CreateGganbuPostModel {
  Future<void> uploadData({required Map<String, dynamic> data}) async {
    await FirebaseFirestore.instance
        .collection('RegisteredPost')
        .doc('FindPages')
        .collection('GganbuPost')
        .doc(data['uid'])
        .set(data);
  }

  Future<void> linkGganbuPost({required String uid}) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('MyPosts')
        .doc('GganbuPost')
        .set({'address': uid});
  }
}
