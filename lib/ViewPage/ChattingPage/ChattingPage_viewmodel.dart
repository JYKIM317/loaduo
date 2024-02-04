import 'ChattingPage_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChattingPageViewModel {
  Future<void> sendMessage({
    required String address,
    required String name,
    required String server,
    required String uid,
    required String text,
    required DateTime sendTime,
    required List<dynamic> members,
  }) async {
    String? userUID = FirebaseAuth.instance.currentUser!.uid;
    String messageId =
        'message_${sendTime.toString().replaceAll(RegExp(r'\.|\#|\$|\[|\]|\/\/'), '_')}_$uid';
    String firestoreAddress = address.replaceAll('/Messages', '');
    firestoreAddress = firestoreAddress.replaceAll(RegExp(r'\/'), ' ');
    Map<String, dynamic> messageData = {
      'name': name,
      'server': server,
      'uid': uid,
      'text': text,
      'sendTime': sendTime.toString(),
    };
    await ChattingPageModel().saveMessageData(
      address: address,
      messageId: messageId,
      message: messageData,
    );
    for (final member in members) {
      String memberUID = member.toString();
      ChattingPageModel().updateRecentMessage(
        uid: memberUID,
        address: firestoreAddress,
        sendTime: sendTime,
      );
      if (memberUID != userUID) {
        try {
          http.post(
            Uri.parse(
                'https://asia-northeast3-loaduo.cloudfunctions.net/pushFcm/message'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({
              'call': memberUID,
              'name': name,
              'text': text,
            }),
          );
        } catch (e) {
          print(e);
        }
      }
    }
  }
}
