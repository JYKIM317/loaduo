import 'package:cloud_firestore/cloud_firestore.dart';
import 'FindStatic_model.dart';

class FindStaticViewModel {
  Future<List<Map<String, dynamic>>> getStaticPostList({
    required int count,
    required String? raid,
  }) async {
    List<Map<String, dynamic>> staticPostList = [];
    await FindStaticModel()
        .getDataList(
      count: count,
      raid: raid,
    )
        .then((querySnapshot) {
      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        Map<String, dynamic>? staticPost =
            documentSnapshot.data() as Map<String, dynamic>?;
        if (staticPost != null) {
          staticPostList.add(staticPost);
        }
      }
    });

    return staticPostList;
  }
}
