import 'package:cloud_firestore/cloud_firestore.dart';
import 'FindGganbu_model.dart';

class FindGganbuViewModel {
  Future<Map> getGganbuPostList({
    required int count,
    required String? serverFilter,
    required List<dynamic>? typeFilter,
    required int? weekdayS,
    required int? weekdayE,
    required int? weekendS,
    required int? weekendE,
    required DocumentSnapshot? lastDoc,
    List<Map<String, dynamic>>? initialList,
  }) async {
    Map postLoadData = {};
    List<Map<String, dynamic>> gganbuPostList = initialList ?? [];
    await FindGganbuModel()
        .getDataList(
      count: count,
      server: serverFilter,
      type: typeFilter,
      weekdayS: weekdayS,
      weekdayE: weekdayE,
      weekendS: weekendS,
      weekendE: weekendE,
      lastDoc: lastDoc,
    )
        .then((querySnapshot) {
      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        Map<String, dynamic>? gganbuPost =
            documentSnapshot.data() as Map<String, dynamic>?;
        if (gganbuPost != null) {
          if (documentSnapshot.id == querySnapshot.docs.last.id) {
            postLoadData.addAll({'lastDoc': documentSnapshot});
          }
          if (weekdayS != null &&
              weekdayE != null &&
              weekendS != null &&
              weekendE != null) {
            if (gganbuPost['weekendPlaytime'] >= weekendS &&
                gganbuPost['weekendPlaytime'] <= weekendE) {
              gganbuPostList.add(gganbuPost);
            }
          } else {
            gganbuPostList.add(gganbuPost);
          }
        }
      }
      postLoadData.addAll({'postList': gganbuPostList});
    });
    return postLoadData;
  }
}
