import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'RaidForTodayPostView_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

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
    required String leader,
    required Map<String, dynamic> data,
  }) async {
    await RaidForTodayPostModel()
        .setJoinRequest(
      address: address,
      uid: uid,
      data: data,
    )
        .then((_) async {
      try {
        http.post(
          Uri.parse(
              'https://asia-northeast3-loaduo.cloudfunctions.net/pushFcm/request'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({'call': leader}),
        );
      } catch (e) {
        print(e);
      }
    });
  }

  Future<void> removeRequest({
    required String address,
    required String uid,
    bool? accept,
  }) async {
    String? userUID = FirebaseAuth.instance.currentUser!.uid;
    accept ??= false;
    await RaidForTodayPostModel()
        .requestCharacterRemove(
      address: address,
      uid: uid,
    )
        .then((_) async {
      if (uid != userUID && !accept!) {
        try {
          http.post(
            Uri.parse(
                'https://asia-northeast3-loaduo.cloudfunctions.net/pushFcm/denied'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({'call': uid}),
          );
        } catch (e) {
          print(e);
        }
      }
    });
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
        await RaidForTodayPostModel()
            .acceptRequestCharacter(
          address: address,
          characterData: characterData,
        )
            .then((_) async {
          Map<String, dynamic> characterInfo = {
            'name': characterData['CharacterName'],
            'server': characterData['ServerName'],
            'uid': characterData['uid'],
            'credential': characterData['credential'],
          };

          await RaidForTodayPostModel().setUserToChattingAddress(
            address: address,
            uid: characterData['uid'],
            info: characterInfo,
          );

          try {
            http.post(
              Uri.parse(
                  'https://asia-northeast3-loaduo.cloudfunctions.net/pushFcm/accept'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode({'call': character.id}),
            );
          } catch (e) {
            print(e);
          }
        });
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

            await RaidForTodayPostModel()
                .removeUserToChattingAddress(address: address, uid: uid);
          });
        } else {
          await RaidForTodayPostModel()
              .removeJoinCharacter(address: address, uid: uid)
              .then((_) async {
            await RaidForTodayPostModel()
                .removeUserToChattingAddress(address: address, uid: uid);

            try {
              http.post(
                Uri.parse(
                    'https://asia-northeast3-loaduo.cloudfunctions.net/pushFcm/leave'),
                headers: <String, String>{
                  'Content-Type': 'application/json; charset=UTF-8',
                },
                body: jsonEncode({'call': post['raidLeader']}),
              );
            } catch (e) {
              print(e);
            }
          });
        }
      }
    });
  }

  Future<Map<String, dynamic>> getPostData({required String address}) async {
    Map<String, dynamic> postData = {};
    await RaidForTodayPostModel().getPostDoc(address: address).then((post) {
      Map<String, dynamic>? readyPostData =
          post.data() as Map<String, dynamic>?;
      if (readyPostData != null && readyPostData.isNotEmpty) {
        postData = readyPostData;
      }
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
