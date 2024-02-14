import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class MatchMakingModel {
  Future<void> registerStandByData({
    required String uid,
    required Map<String, dynamic> data,
  }) async {
    await FirebaseFirestore.instance
        .collection('MatchMakingStandBy')
        .doc(uid)
        .set(data);
  }

  Future<void> removeStandbyData({required String uid}) async {
    await FirebaseFirestore.instance
        .collection('MatchMakingStandBy')
        .doc(uid)
        .delete();
  }

  Future<void> initializeAnonymousChatting({required String uid}) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('AnonymousChat')
        .doc('address')
        .delete();
  }

  Future<Map<String, dynamic>> existAnonymousChatting({
    required String uid,
    required String address,
  }) async {
    bool exist = false;
    late Map<String, dynamic> response;
    DatabaseReference chatInfo = FirebaseDatabase.instance.ref('$address/info');
    DataSnapshot? chatSnapshot = await chatInfo.get();
    Map<dynamic, dynamic>? addressData =
        chatSnapshot.value as Map<dynamic, dynamic>?;
    if (addressData != null) {
      List<dynamic> userList = addressData.keys.toList();
      userList.remove(uid);
      String otherPerson = userList.first.toString();
      exist = true;
      response = {
        'exist': exist,
        'otherPerson': otherPerson,
        'info': {
          'credential': addressData[uid]['credential'],
          'name': addressData[uid]['name'],
          'server': addressData[uid]['server'],
          'uid': addressData[uid]['uid'],
        },
      };
    } else {
      response = {'exist': exist};
    }

    return response;
  }
}
