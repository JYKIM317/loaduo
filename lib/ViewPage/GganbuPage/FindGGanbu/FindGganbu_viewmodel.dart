import 'package:cloud_firestore/cloud_firestore.dart';
import 'FindGganbu_model.dart';

class FindGganbuViewModel {
  Future<List<Map<String, dynamic>>> getGganbuPostList({
    required int count,
    required String? serverFilter,
    required List<dynamic>? typeFilter,
    required int? weekdayS,
    required int? weekdayE,
    required int? weekendS,
    required int? weekendE,
  }) async {
    List<Map<String, dynamic>> gganbuPostList = [];
    await FindGganbuModel()
        .getDataList(
      count: count,
      server: serverFilter,
      type: typeFilter,
      weekdayS: weekdayS,
      weekdayE: weekdayE,
      weekendS: weekendS,
      weekendE: weekendE,
    )
        .then((querySnapshot) {
      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        Map<String, dynamic>? gganbuPost =
            documentSnapshot.data() as Map<String, dynamic>?;
        if (gganbuPost != null) {
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
    });
    return gganbuPostList;
  }
}
