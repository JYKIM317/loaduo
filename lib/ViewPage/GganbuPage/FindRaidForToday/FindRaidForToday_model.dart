import 'package:cloud_firestore/cloud_firestore.dart';

class FindRaidForTodayModel {
  Future<QuerySnapshot> getDataList({
    required int count,
    required String? raid,
    required String? skill,
    required DateTime? timeS,
    required DateTime? timeE,
    required DocumentSnapshot? lastDoc,
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

    if (lastDoc == null) {
      postList = postList.orderBy('postTime', descending: true);
    } else {
      postList = postList
          .orderBy('postTime', descending: true)
          .startAfterDocument(lastDoc);
    }

    QuerySnapshot filteredPostList = await postList.limit(count).get();

    return filteredPostList;
  }
}
