import 'package:cloud_firestore/cloud_firestore.dart';

class MyPageModel {
  Future<dynamic> getUserData(String uid) async {
    final myDB =
        await FirebaseFirestore.instance.collection('Users').doc(uid).get();
    return myDB;
  }

  Future<Map<String, dynamic>> getUserPostData(String uid) async {
    Map<String, dynamic> postDatas = {};
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('MyPosts')
        .get()
        .then((querySnapshot) async {
      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        String postName = documentSnapshot.id;
        if (postName == 'GganbuPost') {
          String postAddress = await documentSnapshot.get('address');
          await FirebaseFirestore.instance
              .collection('RegisteredPost')
              .doc('FindPages')
              .collection('GganbuPost')
              .doc(postAddress)
              .get()
              .then((post) {
            Map<String, dynamic>? postData = post.data();
            if (postData != null) {
              postDatas.addAll({'GganbuPost': postData});
            }
          });
        } else if (postName == 'GuildPost') {
          String postAddress = await documentSnapshot.get('address');
          await FirebaseFirestore.instance
              .collection('RegisteredPost')
              .doc('FindPages')
              .collection('GuildPost')
              .doc(postAddress)
              .get()
              .then((post) {
            Map<String, dynamic>? postData = post.data();
            if (postData != null) {
              postDatas.addAll({'GuildPost': postData});
            }
          });
        } else if (postName == 'RaidForTodayPost') {
          List<Map<String, dynamic>> raidForTodayPostList = [];
          List<dynamic> postAddress = await documentSnapshot.get('address');
          for (String eachPostAddress in postAddress) {
            await FirebaseFirestore.instance
                .collection('RegisteredPost')
                .doc('FindPages')
                .collection('RaidForTodayPost')
                .doc(eachPostAddress)
                .get()
                .then((post) {
              Map<String, dynamic>? postData = post.data();
              if (postData != null) {
                raidForTodayPostList.add(postData);
              }
            });
          }
          if (raidForTodayPostList.isNotEmpty) {
            postDatas.addAll({'RaidForTodayPost': raidForTodayPostList});
          }
        } else if (postName == 'StaticPost') {
          List<Map<String, dynamic>> staticPostList = [];
          List<dynamic> postAddress = await documentSnapshot.get('address');
          for (String eachPostAddress in postAddress) {
            await FirebaseFirestore.instance
                .collection('RegisteredPost')
                .doc('FindPages')
                .collection('StaticPost')
                .doc(eachPostAddress)
                .get()
                .then((post) {
              Map<String, dynamic>? postData = post.data();
              if (postData != null) {
                staticPostList.add(postData);
              }
            });
          }
          if (staticPostList.isNotEmpty) {
            postDatas.addAll({'StaticPost': staticPostList});
          }
        }
      }
    });
    return postDatas;
  }
}
