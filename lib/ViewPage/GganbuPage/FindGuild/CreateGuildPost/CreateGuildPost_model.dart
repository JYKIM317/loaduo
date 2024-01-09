import 'package:cloud_firestore/cloud_firestore.dart';

class CreateGuildPostModel {
  Future<void> uploadData({required Map<String, dynamic> data}) async {
    await FirebaseFirestore.instance
        .collection('RegisteredPost')
        .doc('FindPages')
        .collection('GuildPost')
        .doc(data['uid'])
        .set(data);
  }

  Future<void> linkGuildPost({required String uid}) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('MyPosts')
        .doc('GuildPost')
        .set({'address': uid});
  }
}
