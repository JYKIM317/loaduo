import 'package:cloud_firestore/cloud_firestore.dart';
import 'FindGuild_model.dart';

class FindGuildViewModel {
  Future<List<Map<String, dynamic>>> getGuildPostList({
    required int count,
    required String? server,
    required String? type,
    required int? level,
  }) async {
    List<Map<String, dynamic>> guildPostList = [];
    await FindGuildModel()
        .getDataList(
      count: count,
      server: server,
      type: type,
      level: level,
    )
        .then((querySnapshot) {
      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        Map<String, dynamic>? guildPost =
            documentSnapshot.data() as Map<String, dynamic>?;
        if (guildPost != null) {
          guildPostList.add(guildPost);
        }
      }
    });

    return guildPostList;
  }
}
