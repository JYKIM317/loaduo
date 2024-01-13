import 'package:cloud_firestore/cloud_firestore.dart';

class FindGganbuModel {
  Future<QuerySnapshot> getDataList({
    required int count,
    required String? server,
    required List<dynamic>? type,
    required int? weekdayS,
    required int? weekdayE,
    required int? weekendS,
    required int? weekendE,
    required DocumentSnapshot? lastDoc,
  }) async {
    Query postList = FirebaseFirestore.instance
        .collection('RegisteredPost')
        .doc('FindPages')
        .collection('GganbuPost');
    if (server != null) {
      postList = postList.where('representServer', isEqualTo: server);
    }
    if (type != null) {
      postList = postList.where('concern', arrayContainsAny: type);
    }
    if (weekdayS != null && weekdayE != null) {
      postList = postList
          .where('weekdayPlaytime', isGreaterThanOrEqualTo: weekdayS)
          .where('weekdayPlaytime', isLessThanOrEqualTo: weekdayE)
          .orderBy(
            'weekdayPlaytime',
            descending: true,
          );
    }
    if (weekdayS == null &&
        weekdayE == null &&
        weekendS != null &&
        weekendE != null) {
      postList = postList
          .where('weekendPlaytime', isGreaterThanOrEqualTo: weekendS)
          .where('weekendPlaytime', isLessThanOrEqualTo: weekendE)
          .orderBy(
            'weekendPlaytime',
            descending: true,
          );
    } else if (weekendS != null &&
        weekendE != null &&
        weekdayS != null &&
        weekdayE != null) {
      count += 30;
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
