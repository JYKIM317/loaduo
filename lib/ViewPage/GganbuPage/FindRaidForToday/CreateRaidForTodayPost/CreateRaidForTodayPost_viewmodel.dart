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
    //non-empty string and not contain '.' '#' '$' '[' or ']''
    String address =
        '${raidLeader}_${now.toString().replaceAll(RegExp(r'\.|\#|\$|\[|\]|\/\/| '), '_')}';
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

    Map<String, dynamic> characterInfo = {
      'name': myCharacter['CharacterName'],
      'server': myCharacter['ServerName'],
      'uid': raidLeader,
      'credential': myCharacter['credential'],
    };
    late int startHour;
    if (startTime.hour >= 13) {
      startHour = startTime.hour - 12;
    } else {
      if (startTime.hour == 0) {
        startHour = startTime.hour + 12;
      } else {
        startHour = startTime.hour;
      }
    }
    String title = raid;
    String subtitle =
        '${startTime.hour >= 12 ? '오후' : '오전'} $startHour시 ${startTime.minute.toString().padLeft(2, '0')}분';
    Map<String, dynamic> chatInfo = {raidLeader: characterInfo};

    await CreateRaidForTodayPostModel().uploadData(
      data: postInfo,
      character: myCharacter,
      address: address,
    );
    await CreateRaidForTodayPostModel().linkRaidForTodayPost(
      uid: raidLeader,
      address: address,
    );
    await CreateRaidForTodayPostModel().setChattingAddress(
      address: address,
      uid: raidLeader,
      info: chatInfo,
      title: title,
      subtitle: subtitle,
    );
  }
}
