import 'package:cloud_firestore/cloud_firestore.dart';
import 'FindRaidForToday_model.dart';

class FindRaidForTodayViewModel {
  Future<List<Map<String, dynamic>>> getRaidForTodayPostList({
    required int count,
    required String? raid,
    required String? skill,
    required DateTime? timeS,
    required DateTime? timeE,
  }) async {
    List<Map<String, dynamic>> raidForTodayPostList = [];
    await FindRaidForTodayModel()
        .getDataList(
      count: count,
      raid: raid,
      skill: skill,
      timeS: timeS,
      timeE: timeE,
    )
        .then((querySnapshot) {
      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        Map<String, dynamic>? raidForTodayPost =
            documentSnapshot.data() as Map<String, dynamic>?;
        if (raidForTodayPost != null) {
          raidForTodayPostList.add(raidForTodayPost);
        }
      }
    });

    return raidForTodayPostList;
  }
}
