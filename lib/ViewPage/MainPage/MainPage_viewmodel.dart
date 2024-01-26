import 'MainPage_model.dart';

class MainPageViewModel {
  Future<bool> blockUserCheck({required String uid}) async {
    late bool state;
    final blockUser = await MainPageModle().getBlockUserData(uid: uid);

    state = blockUser.exists;
    return state;
  }
}
