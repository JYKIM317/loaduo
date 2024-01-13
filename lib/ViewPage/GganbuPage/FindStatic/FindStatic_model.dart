import 'package:cloud_firestore/cloud_firestore.dart';

class FindStaticModel {
  Future<QuerySnapshot> getDataList({
    required int count,
    required String? raid,
    required DocumentSnapshot? lastDoc,
  }) async {
    Query postList = FirebaseFirestore.instance
        .collection('RegisteredPost')
        .doc('FindPages')
        .collection('StaticPost');
    if (raid != null) {
      postList = postList.where('raid', isEqualTo: raid);
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
