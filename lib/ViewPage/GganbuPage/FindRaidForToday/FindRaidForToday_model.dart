import 'package:cloud_firestore/cloud_firestore.dart';

class FindRaidForTodayModel {
  Future<QuerySnapshot> getDataList({
    required int count,
    required String? raid,
    required String? skill,
    required DateTime? timeS,
    required DateTime? timeE,
  }) async {
    Query postList = FirebaseFirestore.instance
        .collection('RegisteredPost')
        .doc('FindPages')
        .collection('RaidForTodayPost');
    if (raid != null) {
      postList = postList.where('raid', isEqualTo: raid);
    }
    if (skill != null) {
      postList = postList.where('skill', isEqualTo: skill);
    }
    if (timeS != null && timeE != null) {
      postList = postList
          .where('startTime',
              isGreaterThanOrEqualTo: timeS, isLessThanOrEqualTo: timeE)
          .orderBy('startTime');
    }

    QuerySnapshot filteredPostList =
        await postList.orderBy('postTime', descending: true).limit(count).get();

    return filteredPostList;
  }
}
