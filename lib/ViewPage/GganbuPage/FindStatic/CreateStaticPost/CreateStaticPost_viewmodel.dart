import 'CreateStaticPost_model.dart';

class CreateStaticPostViewModel {
  Future<void> uploadPost({
    required String raidLeader,
    required String raid,
    required String raidName,
    required int raidMaxPlayer,
    required String detail,
    required Map<String, dynamic> myCharacter,
  }) async {
    DateTime now = DateTime.now();
    Map<String, dynamic> postInfo = {
      'raidLeader': raidLeader,
      'raid': raid,
      'raidName': raidName,
      'raidMaxPlayer': raidMaxPlayer,
      'detail': detail,
      'postTime': now,
    };
    String address =
        '${raidLeader}_${now.year}.${now.month}.${now.day}_${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
    await CreateStaticPostModel().uploadData(
      data: postInfo,
      character: myCharacter,
      address: address,
    );
    await CreateStaticPostModel().linkStaticPost(
      uid: raidLeader,
      address: address,
    );
  }
}
