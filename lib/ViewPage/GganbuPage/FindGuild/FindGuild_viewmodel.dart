import 'package:cloud_firestore/cloud_firestore.dart';
import 'FindGuild_model.dart';

class FindGuildViewModel {
  Future<Map> getGuildPostList({
    required int count,
    required String? server,
    required String? type,
    required int? level,
    required DocumentSnapshot? lastDoc,
    List<Map<String, dynamic>>? initialList,
  }) async {
    Map postLoadData = {};
    List<Map<String, dynamic>> guildPostList = [];
    await FindGuildModel()
        .getDataList(
      count: count,
      server: server,
      type: type,
      level: level,
      lastDoc: lastDoc,
    )
        .then((querySnapshot) {
      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        Map<String, dynamic>? guildPost =
            documentSnapshot.data() as Map<String, dynamic>?;
        if (guildPost != null) {
          if (documentSnapshot.id == querySnapshot.docs.last.id) {
            postLoadData.addAll({'lastDoc': documentSnapshot});
          }
          guildPostList.add(guildPost);
        }
      }
      postLoadData.addAll({'postList': guildPostList});
    });
    return postLoadData;
  }
}
