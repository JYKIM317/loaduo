import 'package:cloud_firestore/cloud_firestore.dart';

class FindGuildModel {
  Future<QuerySnapshot> getDataList({
    required int count,
    required String? server,
    required String? type,
    required int? level,
    required DocumentSnapshot? lastDoc,
  }) async {
    Query postList = FirebaseFirestore.instance
        .collection('RegisteredPost')
        .doc('FindPages')
        .collection('GuildPost');
    if (server != null) {
      postList = postList.where('server', isEqualTo: server);
    }
    if (type != null) {
      postList = postList.where('guildType', isEqualTo: type);
    }
    if (level != null) {
      postList =
          postList.where('level', isLessThanOrEqualTo: level).orderBy('level');
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
