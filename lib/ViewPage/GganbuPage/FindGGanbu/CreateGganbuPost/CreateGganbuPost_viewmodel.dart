import 'package:loaduo/ViewPage/GganbuPage/FindGGanbu/CreateGganbuPost/CreateGganbuPost_model.dart';

class CreateGganbuPostViewModel {
  Future<void> uploadPost({
    required String uid,
    required String representCharacter,
    required String credentialCharacter,
    required String representServer,
    required String raidSkill,
    required String raidMood,
    required String raidDistribute,
    required List<dynamic> concern,
    required int weekdayPlaytime,
    required int weekendPlaytime,
    required String detail,
  }) async {
    DateTime now = DateTime.now();
    Map<String, dynamic> postInfo = {
      'uid': uid,
      'representCharacter': representCharacter,
      'credentialCharacter': credentialCharacter,
      'representServer': representServer,
      'raidSkill': raidSkill,
      'raidMood': raidMood,
      'raidDistribute': raidDistribute,
      'concern': concern,
      'weekdayPlaytime': weekdayPlaytime,
      'weekendPlaytime': weekendPlaytime,
      'detail': detail,
      'postTime': now.millisecondsSinceEpoch,
    };
    await CreateGganbuPostModel().uploadData(data: postInfo);
    await CreateGganbuPostModel().linkGganbuPost(uid: uid);
  }
}
