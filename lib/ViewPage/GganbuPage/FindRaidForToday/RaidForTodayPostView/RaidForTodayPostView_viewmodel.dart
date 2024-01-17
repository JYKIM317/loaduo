import 'package:cloud_firestore/cloud_firestore.dart';
import 'RaidForTodayPostView_model.dart';

class RaidForTodayPostViewModel {
  Future<List<Map<String, dynamic>>> getJoinCharacterList(
      {required String address}) async {
    List<Map<String, dynamic>> joinCharacterList = [];
    await RaidForTodayPostModel()
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
    await RaidForTodayPostModel().setJoinRequest(
      address: address,
      uid: uid,
      data: data,
    );
  }

  Future<void> removeRequest({
    required String address,
    required String uid,
  }) async {
    await RaidForTodayPostModel().requestCharacterRemove(
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

    await RaidForTodayPostModel()
        .getPostDoc(address: address)
        .then((postDoc) async {
      Map<String, dynamic> postData = postDoc.data() as Map<String, dynamic>;
      if (postData['raidPlayer'] < postData['raidMaxPlayer']) {
        await RaidForTodayPostModel().acceptRequestCharacter(
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
    await RaidForTodayPostModel()
        .checkPostData(address: address, uid: uid)
        .then((post) async {
      if (post.isNotEmpty) {
        if (post['raidLeader'] == uid) {
          //리더 교체 로직
          await RaidForTodayPostModel()
              .changeLeader(address: address, uid: uid)
              .then((_) async {
            await RaidForTodayPostModel()
                .removeJoinCharacter(address: address, uid: uid);
          });
        } else {
          await RaidForTodayPostModel()
              .removeJoinCharacter(address: address, uid: uid);
        }
      }
    });
  }

  Future<Map<String, dynamic>> getPostData({required String address}) async {
    Map<String, dynamic> postData = {};
    await RaidForTodayPostModel().getPostDoc(address: address).then((post) {
      postData = post.data() as Map<String, dynamic>;
    });
    return postData;
  }

  Future<void> updatePostTime(
      {required String address, required DateTime postTime}) async {
    Map<String, dynamic> data = {
      'postTime': postTime,
    };
    await RaidForTodayPostModel().updatePost(
      address: address,
      postData: data,
    );
  }
}
