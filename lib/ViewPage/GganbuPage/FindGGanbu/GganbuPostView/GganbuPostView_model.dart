import 'package:cloud_firestore/cloud_firestore.dart';

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
          .delete();
    });
  }
}
