import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
          String postAddress = '';
          try {
            postAddress = await documentSnapshot.get('address');
          } catch (e) {
            postAddress = '';
          }
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
          String postAddress = '';
          try {
            postAddress = await documentSnapshot.get('address');
          } catch (e) {
            postAddress = '';
          }
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
          List<dynamic>? postAddress;
          try {
            postAddress = await documentSnapshot.get('address');
          } catch (e) {
            postAddress = [];
          }
          for (String eachPostAddress in postAddress ?? []) {
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
          List<dynamic>? postAddress;
          try {
            postAddress = await documentSnapshot.get('address');
          } catch (e) {
            postAddress = [];
          }
          for (String eachPostAddress in postAddress ?? []) {
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

  Future<List<String>> getMyBlockUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> blockedUserList = prefs.getStringList('blockedUserList') ?? [];

    return blockedUserList;
  }

  Future<void> updateMyBlockUser({
    required List<String> blockUserList,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('blockedUserList', blockUserList);
  }
}
