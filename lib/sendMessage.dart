import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

Future<void> sendMessage({
  required String fcmToken,
  required String state,
}) async {
  final private =
      await FirebaseFirestore.instance.collection('Private').doc('Key').get();
  String oAuthToken = private.get('OAuthToken');

  late String title, body;

  if (state == 'request') {
    title = '로아핸즈';
    body = '파티 모집에 새로운 신청이 있습니다.';
  }
  if (state == 'leave') {
    title = '로아핸즈';
    body = '누군가 모집에서 탈퇴하였습니다.';
  }
  if (state == 'accept') {
    title = '로아핸즈';
    body = '신청하신 모집에 가입되셨습니다.';
  }
  if (state == 'leader') {
    title = '로아핸즈';
    body = '파티장이 모집에서 탈퇴 해 파티장을 위임받으셨습니다.';
  }

  //http.Response response;
  try {
    await http.post(
      Uri.parse('https://fcm.googleapis.com/v1/projects/loaduo/messages:send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $oAuthToken', //http v1으로 마이그레이션 해야함
      },
      body: jsonEncode({
        'message': {
          'token': fcmToken,
          'notification': {
            'title': title,
            'body': body,
          },
          'data': {
            'click_action': 'click action',
          },
          "android": {
            "notification": {
              "click_action": "Android Click Action",
            }
          },
          "apns": {
            "payload": {
              "aps": {
                "category": "Message Category",
                "content-available": 1,
              }
            }
          },
        }
      }),
    );
  } catch (e) {
    print('error $e');
  }
}
