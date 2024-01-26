import 'package:firebase_database/firebase_database.dart';
import 'package:loaduo/gaEventLog.dart';
import 'GganbuPostView_model.dart';

class GganbuPostViewModel {
  Future<Map<String, dynamic>> getPostData({required String address}) async {
    Map<String, dynamic> postData = {};
    await GganbuPostModel().getPostDoc(address: address).then((post) {
      postData = post.data() as Map<String, dynamic>;
    });
    return postData;
  }

  Future<void> updatePostTime(
      {required String address, required DateTime postTime}) async {
    Map<String, dynamic> data = {
      'postTime': postTime,
    };
    await GganbuPostModel().updatePost(
      address: address,
      postData: data,
    );
  }

  Future<void> removePostData({required String address}) async {
    await GganbuPostModel().removePost(address: address);
  }

  Future<void> existConversation({
    required String address,
    required String uid,
    required Map<String, dynamic> post,
    required Map<String, dynamic> requestUserData,
  }) async {
    await GganbuPostModel()
        .getChattingExist(
      address: address,
      uid: uid,
    )
        .then((exist) async {
      if (exist) {
        return;
      } else {
        bool hostCredential =
                post['representCharacter'] == post['credentialCharacter'],
            guestCredential = requestUserData['representCharacter'] ==
                (requestUserData['credentialCharacter'] ?? '');

        Map<String, dynamic> info = {
          address: {
            'name': post['representCharacter'],
            'server': post['representServer'],
            'uid': address,
            'credential': hostCredential,
          },
          uid: {
            'name': requestUserData['representCharacter'],
            'server': requestUserData['representServer'],
            'uid': uid,
            'credential': guestCredential,
          },
        };
        await GganbuPostModel().setChattingAddress(
          address: address,
          uid: uid,
          info: info,
        );
        await gaEvent(
          eventName: 'Create_Chatting',
          eventParams: info,
        );
        return;
      }
    });
  }

  Future<Map<dynamic, dynamic>> getChattingInfo({
    required String address,
    required String uid,
  }) async {
    DataSnapshot chattingInfo = await GganbuPostModel().getChattingData(
      address: address,
      uid: uid,
    );
    Map<dynamic, dynamic> userInfos =
        chattingInfo.value as Map<dynamic, dynamic>;
    return userInfos;
  }
}
