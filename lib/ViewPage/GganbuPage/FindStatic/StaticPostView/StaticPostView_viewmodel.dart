import 'package:cloud_firestore/cloud_firestore.dart';
import 'StaticPostView_model.dart';

class StaticPostViewModel {
  Future<List<Map<String, dynamic>>> getJoinCharacterList(
      {required String address}) async {
    List<Map<String, dynamic>> joinCharacterList = [];
    await StaticPostModel()
        .joinChracterData(address: address)
        .then((querySnapshot) {
      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        Map<String, dynamic>? joinCharacter =
            documentSnapshot.data() as Map<String, dynamic>?;
        if (joinCharacter != null) {
          joinCharacterList.add(joinCharacter);
        }
      }
    });

    return joinCharacterList;
  }

  Future<void> joinRequest({
    required String address,
    required String uid,
    required Map<String, dynamic> data,
  }) async {
    await StaticPostModel().setJoinRequest(
      address: address,
      uid: uid,
      data: data,
    );
  }

  Future<void> removeRequest({
    required String address,
    required String uid,
  }) async {
    await StaticPostModel().requestCharacterRemove(
      address: address,
      uid: uid,
    );
  }

  Future<bool> acceptRequest({
    required String address,
    required DocumentSnapshot character,
  }) async {
    bool result = true;
    Map<String, dynamic> characterData =
        character.data() as Map<String, dynamic>;

    await StaticPostModel().getPostDoc(address: address).then((postDoc) async {
      Map<String, dynamic> postData = postDoc.data() as Map<String, dynamic>;
      if (postData['raidPlayer'] < postData['raidMaxPlayer']) {
        await StaticPostModel().acceptRequestCharacter(
          address: address,
          characterData: characterData,
        );
      } else {
        result = false;
      }
    });

    return result;
  }

  Future<void> leaveParty({
    required String address,
    required String uid,
  }) async {
    await StaticPostModel()
        .checkPostData(address: address, uid: uid)
        .then((post) async {
      if (post.isNotEmpty) {
        if (post['raidLeader'] == uid) {
          //리더 교체 로직
          await StaticPostModel()
              .changeLeader(address: address, uid: uid)
              .then((_) async {
            await StaticPostModel()
                .removeJoinCharacter(address: address, uid: uid);
          });
        } else {
          await StaticPostModel()
              .removeJoinCharacter(address: address, uid: uid);
        }
      }
    });
  }

  Future<Map<String, dynamic>> getPostData({required String address}) async {
    Map<String, dynamic> postData = {};
    await StaticPostModel().getPostDoc(address: address).then((post) {
      postData = post.data() as Map<String, dynamic>;
    });
    return postData;
  }

  Future<void> updatePostTime(
      {required String address, required DateTime postTime}) async {
    Map<String, dynamic> data = {
      'postTime': postTime,
    };
    await StaticPostModel().updatePost(
      address: address,
      postData: data,
    );
  }
}
