import 'MyPage_model.dart';
import 'package:loaduo/ViewPage/MyPage/AddMyCharacter/AddMyCharacter_model.dart';
import 'package:loaduo/ViewPage/SearchUserPage/SearchUserPage_model.dart';
import 'dart:convert';

class MyPageViewModel {
  Future<Map<String, dynamic>> getUserInfo(String uid) async {
    final userDB = await MyPageModel().getUserData(uid);
    Map<String, dynamic> userInfo = userDB.data() ?? {};
    userInfo.remove('lastLogin');
    return userInfo;
  }

  Future<List<Map<String, dynamic>>> getUserExpedition(String uid) async {
    List<Map<String, dynamic>> expedition = [];
    final userDB = await MyPageModel().getUserData(uid);
    Map<String, dynamic> userData = userDB.data() ?? {};
    String? server = userData['representServer'];
    String? character = userData['representCharacter'];

    if (server != null && character != null) {
      var response = await AddMyCharacterModel()
          .getUserSiblingsDataAPI(userName: character);
      int statusCode = response.statusCode;
      if (statusCode == 200) {
        var body = jsonDecode(response.body);
        if (body != null) {
          for (final character in body) {
            if (character['ServerName'] == server) {
              expedition.add(character);
            }
          }
          expedition.sort(
            ((a, b) => double.parse(a['ItemAvgLevel'].replaceAll(',', ''))
                .compareTo(
                    double.parse(b['ItemAvgLevel'].replaceAll(',', '')))),
          );
          expedition = expedition.reversed.toList();
        }
      }
    }
    return expedition;
  }

  Future<Map<String, dynamic>?> getCharacterData(
      {required String userName}) async {
    var response =
        await SearchUserPageModel().getUserDataAPI(userName: userName);
    int statusCode = response.statusCode;
    var body;
    if (statusCode == 200) {
      body = jsonDecode(response.body);
    }
    Map<String, dynamic> responseData = {
      'statusCode': statusCode,
      'body': body,
    };
    return responseData;
  }

  Future<Map<String, dynamic>> getUserPost(String uid) async {
    Map<String, dynamic> userPost = await MyPageModel().getUserPostData(uid);
    return userPost;
  }
}
