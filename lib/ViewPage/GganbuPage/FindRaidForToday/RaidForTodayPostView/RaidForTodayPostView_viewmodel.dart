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
}
