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
    //non-empty string and not contain '.' '#' '$' '[' or ']''
    String address =
        '${raidLeader}_${now.toString().replaceAll(RegExp(r'\.|\#|\$|\[|\]|\/\/| '), '_')}';
    Map<String, dynamic> postInfo = {
      'raidLeader': raidLeader,
      'raid': raid,
      'raidName': raidName,
      'raidPlayer': 1,
      'raidMaxPlayer': raidMaxPlayer,
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
    String title = raid;
    String subtitle = '고정공대';
    Map<String, dynamic> chatInfo = {raidLeader: characterInfo};

    await CreateStaticPostModel().uploadData(
      data: postInfo,
      character: myCharacter,
      address: address,
    );
    await CreateStaticPostModel().linkStaticPost(
      uid: raidLeader,
      address: address,
    );
    await CreateStaticPostModel().setChattingAddress(
      address: address,
      uid: raidLeader,
      info: chatInfo,
      title: title,
      subtitle: subtitle,
    );
  }
}
