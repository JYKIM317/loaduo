import 'MyPage_model.dart';

class MyPageViewModel {
  Future<Map<String, dynamic>> getUserInfo(String uid) async {
    final myDB = await MyPageModel().getUserData(uid);
    Map<String, dynamic> userInfo = myDB.data() ?? {};
    userInfo.remove('lastLogin');
    return userInfo;
  }
}
