import 'package:cloud_firestore/cloud_firestore.dart';

class CreateRaidForTodayPostModel {
  Future<void> uploadData({
    required Map<String, dynamic> data,
    required Map<String, dynamic> character,
    required String address,
  }) async {
    await FirebaseFirestore.instance
        .collection('RegisteredPost')
        .doc('FindPages')
        .collection('RaidForTodayPost')
        .doc(address)
        .set(data);

    await FirebaseFirestore.instance
        .collection('RegisteredPost')
        .doc('FindPages')
        .collection('RaidForTodayPost')
        .doc(address)
        .collection('JoinCharacter')
        .doc(data['raidLeader'])
        .set(character);
  }

  Future<void> linkRaidForTodayPost({
    required String uid,
    required String address,
  }) async {
    //raidfortodaypost 가져와서 add하고 list로 바꿔서 넣기
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('MyPosts')
        .doc('RaidForTodayPost')
        .set({'address': address});
  }
}
