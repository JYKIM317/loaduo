import 'package:cloud_firestore/cloud_firestore.dart';

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
          .update({'raidPlayer': FieldValue.increment(-1)}).then((_) async {
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
            .update({'raidLeader': leftUserUid});
      } else {
        //남은 유저 없음
        await FirebaseFirestore.instance
            .collection('RegisteredPost')
            .doc('FindPages')
            .collection('StaticPost')
            .doc(address)
            .delete();
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
}
