import 'CreateRaidForTodayPost_model.dart';

class CreateRaidForTodayPostViewModel {
  Future<void> uploadPost({
    required String raidLeader,
    required String raid,
    required String raidName,
    required int raidMaxPlayer,
    required String skill,
    required DateTime startTime,
    required String detail,
    required Map<String, dynamic> myCharacter,
  }) async {
    DateTime now = DateTime.now();
    String address =
        '${raidLeader}_${now.year}.${now.month}.${now.day}_${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
    Map<String, dynamic> postInfo = {
      'raidLeader': raidLeader,
      'raid': raid,
      'raidName': raidName,
      'raidPlayer': 1,
      'raidMaxPlayer': raidMaxPlayer,
      'skill': skill,
      'startTime': startTime,
      'detail': detail,
      'postTime': now,
      'address': address,
    };

    await CreateRaidForTodayPostModel().uploadData(
      data: postInfo,
      character: myCharacter,
      address: address,
    );
    await CreateRaidForTodayPostModel().linkRaidForTodayPost(
      uid: raidLeader,
      address: address,
    );
  }
}
