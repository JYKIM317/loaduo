import 'package:cloud_firestore/cloud_firestore.dart';

class TermsOfServiceModel {
  Future<void> setUserPolicyAssent({
    required String uid,
    required DateTime assentTime,
  }) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('Policy')
        .doc('TermsOfService')
        .set({
      'assent': true,
      'assentTime': assentTime,
    });
  }
}
