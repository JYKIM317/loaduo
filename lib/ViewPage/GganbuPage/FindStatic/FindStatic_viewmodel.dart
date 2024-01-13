import 'package:cloud_firestore/cloud_firestore.dart';
import 'FindStatic_model.dart';

class FindStaticViewModel {
  Future<Map> getStaticPostList({
    required int count,
    required String? raid,
    required DocumentSnapshot? lastDoc,
    List<Map<String, dynamic>>? initialList,
  }) async {
    Map postLoadData = {};
    List<Map<String, dynamic>> staticPostList = [];
    await FindStaticModel()
        .getDataList(
      count: count,
      raid: raid,
      lastDoc: lastDoc,
    )
        .then((querySnapshot) {
      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        Map<String, dynamic>? staticPost =
            documentSnapshot.data() as Map<String, dynamic>?;
        if (staticPost != null) {
          if (documentSnapshot.id == querySnapshot.docs.last.id) {
            postLoadData.addAll({'lastDoc': documentSnapshot});
          }
          staticPostList.add(staticPost);
        }
      }
      postLoadData.addAll({'postList': staticPostList});
    });
    return postLoadData;
  }
}
