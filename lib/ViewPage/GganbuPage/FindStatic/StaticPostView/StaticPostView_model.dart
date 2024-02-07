import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';

class StaticPostModel {
  Future<QuerySnapshot> joinChracterData({required String address}) async {
    QuerySnapshot joinCharacterList = await FirebaseFirestore.instance
        .collection('RegisteredPost')
        .doc('FindPages')
        .collection('StaticPost')
        .doc(address)
        .collection('JoinCharacter')
        .get();

    return joinCharacterList;
  }

  Future<void> setJoinRequest({
    required String address,
    required String uid,
    required Map<String, dynamic> data,
  }) async {
    await FirebaseFirestore.instance
        .collection('RegisteredPost')
        .doc('FindPages')
        .collection('StaticPost')
        .doc(address)
        .collection('RequestCharacter')
        .doc(uid)
        .set(data);
  }

  Future<void> acceptRequestCharacter({
    required String address,
    required Map<String, dynamic> characterData,
  }) async {
    await FirebaseFirestore.instance
        .collection('RegisteredPost')
        .doc('FindPages')
        .collection('StaticPost')
        .doc(address)
        .collection('JoinCharacter')
        .doc(characterData['uid'])
        .set(characterData)
        .then((_) async {
      await FirebaseFirestore.instance
          .collection('RegisteredPost')
          .doc('FindPages')
          .collection('StaticPost')
          .doc(address)
          .update({'raidPlayer': FieldValue.increment(1)}).then((_) async {
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(characterData['uid'])
            .collection('MyPosts')
            .doc('StaticPost')
            .get()
            .then((posts) async {
          List<dynamic> post = posts['address'] ?? [];
          post.add(address);
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(characterData['uid'])
              .collection('MyPosts')
              .doc('StaticPost')
              .update({'address': post});
        });
      });
    });
  }

  Future<void> requestCharacterRemove({
    required String address,
    required String uid,
  }) async {
    await FirebaseFirestore.instance
        .collection('RegisteredPost')
        .doc('FindPages')
        .collection('StaticPost')
        .doc(address)
        .collection('RequestCharacter')
        .doc(uid)
        .delete();
  }

  Future<Map<String, dynamic>> checkPostData({
    required String address,
    required String uid,
  }) async {
    Map<String, dynamic> post = {};
    await FirebaseFirestore.instance
        .collection('RegisteredPost')
        .doc('FindPages')
        .collection('StaticPost')
        .doc(address)
        .get()
        .then((doc) {
      post = doc.data() ?? {};
    });

    return post;
  }

  Future<void> removeJoinCharacter({
    required String address,
    required String uid,
  }) async {
    await FirebaseFirestore.instance
        .collection('RegisteredPost')
        .doc('FindPages')
        .collection('StaticPost')
        .doc(address)
        .collection('JoinCharacter')
        .doc(uid)
        .delete()
        .then((_) async {
      await FirebaseFirestore.instance
          .collection('RegisteredPost')
          .doc('FindPages')
          .collection('StaticPost')
          .doc(address)
          .get()
          .then((existData) async {
        if (existData.exists) {
          await FirebaseFirestore.instance
              .collection('RegisteredPost')
              .doc('FindPages')
              .collection('StaticPost')
              .doc(address)
              .update({'raidPlayer': FieldValue.increment(-1)});
        }
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(uid)
            .collection('MyPosts')
            .doc('StaticPost')
            .get()
            .then((posts) async {
          List<dynamic> post = posts['address'];
          post.remove(address);
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(uid)
              .collection('MyPosts')
              .doc('StaticPost')
              .update({'address': post});
        });
      });
    });
  }

  Future<void> changeLeader({
    required String address,
    required String uid,
  }) async {
    String? leftUserUid;
    await FirebaseFirestore.instance
        .collection('RegisteredPost')
        .doc('FindPages')
        .collection('StaticPost')
        .doc(address)
        .collection('JoinCharacter')
        .get()
        .then((querySnapshot) async {
      List<QueryDocumentSnapshot> users = querySnapshot.docs;
      for (final document in users) {
        if (document.id != uid) {
          leftUserUid = document.id;
          break;
        }
      }
      if (leftUserUid != null) {
        await FirebaseFirestore.instance
            .collection('RegisteredPost')
            .doc('FindPages')
            .collection('StaticPost')
            .doc(address)
            .update({'raidLeader': leftUserUid}).then((_) async {
          try {
            http.post(
              Uri.parse(
                  'https://asia-northeast3-loaduo.cloudfunctions.net/pushFcm/leader'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode({'call': leftUserUid}),
            );
          } catch (e) {
            print(e);
          }
        });
      } else {
        //남은 유저 없음
        await FirebaseFirestore.instance
            .collection('RegisteredPost')
            .doc('FindPages')
            .collection('StaticPost')
            .doc(address)
            .delete();

        await removeChattingAddress(address: address);
      }
    });
  }

  Future<DocumentSnapshot> getPostDoc({required String address}) async {
    final postData = await FirebaseFirestore.instance
        .collection('RegisteredPost')
        .doc('FindPages')
        .collection('StaticPost')
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
        .collection('StaticPost')
        .doc(address)
        .update(postData);
  }

  Future<void> setUserToChattingAddress({
    required String address,
    required String uid,
    required Map<String, dynamic> info,
  }) async {
    await FirebaseDatabase.instance
        .ref('Chatting/Static/$address/info')
        .update({uid: info}).then((_) async {
      DateTime now = DateTime.now();
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(uid)
          .collection('Chattings')
          .doc('Chatting Static $address')
          .set({
        'resentMessageTime': now,
        'resentCheckTime': now,
      });
    });
  }

  Future<void> removeUserToChattingAddress({
    required String address,
    required String uid,
  }) async {
    await FirebaseDatabase.instance
        .ref('Chatting/Static/$address/info/$uid')
        .remove()
        .then((_) async {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(uid)
          .collection('Chattings')
          .doc('Chatting Static $address')
          .delete();
    });
  }

  Future<void> removeChattingAddress({required String address}) async {
    await FirebaseDatabase.instance.ref('Chatting/Static/$address').remove();
  }
}
