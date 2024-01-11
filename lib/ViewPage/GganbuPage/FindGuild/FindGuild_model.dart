import 'package:cloud_firestore/cloud_firestore.dart';

class FindGuildModel {
  Future<QuerySnapshot> getDataList({
    required int count,
    required String? server,
    required String? type,
    required int? level,
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

    QuerySnapshot filteredPostList =
        await postList.orderBy('postTime', descending: true).limit(count).get();

    return filteredPostList;
  }
}
