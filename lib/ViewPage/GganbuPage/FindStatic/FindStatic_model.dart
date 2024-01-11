import 'package:cloud_firestore/cloud_firestore.dart';

class FindStaticModel {
  Future<QuerySnapshot> getDataList({
    required int count,
    required String? raid,
  }) async {
    Query postList = FirebaseFirestore.instance
        .collection('RegisteredPost')
        .doc('FindPages')
        .collection('StaticPost');
    if (raid != null) {
      postList = postList.where('raid', isEqualTo: raid);
    }

    QuerySnapshot filteredPostList =
        await postList.orderBy('postTime', descending: true).limit(count).get();

    return filteredPostList;
  }
}
