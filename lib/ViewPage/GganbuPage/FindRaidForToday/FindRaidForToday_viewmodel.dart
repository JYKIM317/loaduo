import 'package:cloud_firestore/cloud_firestore.dart';
import 'FindRaidForToday_model.dart';

class FindRaidForTodayViewModel {
  Future<Map> getRaidForTodayPostList({
    required int count,
    required String? raid,
    required String? skill,
    required DateTime? timeS,
    required DateTime? timeE,
    required DocumentSnapshot? lastDoc,
    List<Map<String, dynamic>>? initialList,
  }) async {
    Map postLoadData = {};
    List<Map<String, dynamic>> raidForTodayPostList = initialList ?? [];
    await FindRaidForTodayModel()
        .getDataList(
      count: count,
      raid: raid,
      skill: skill,
      timeS: timeS,
      timeE: timeE,
      lastDoc: lastDoc,
    )
        .then((querySnapshot) {
      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        Map<String, dynamic>? raidForTodayPost =
            documentSnapshot.data() as Map<String, dynamic>?;
        if (raidForTodayPost != null) {
          if (documentSnapshot.id == querySnapshot.docs.last.id) {
            postLoadData.addAll({'lastDoc': documentSnapshot});
          }
          raidForTodayPostList.add(raidForTodayPost);
        }
      }
      postLoadData.addAll({'postList': raidForTodayPostList});
    });
    return postLoadData;
  }
}
