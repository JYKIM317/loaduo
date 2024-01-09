import 'CreateGuildPost_model.dart';

class CreateGuildPostViewModel {
  Future<void> uploadPost({
    required String uid,
    required String server,
    required String guildName,
    required String guildType,
    required int? level,
    required String detail,
  }) async {
    DateTime now = DateTime.now();
    Map<String, dynamic> postInfo = {
      'uid': uid,
      'server': server,
      'guildType': guildType,
      'level': level,
      'detail': detail,
      'postTime': now,
    };
    await CreateGuildPostModel().uploadData(data: postInfo);
    await CreateGuildPostModel().linkGuildPost(uid: uid);
  }
}
