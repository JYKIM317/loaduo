import 'package:firebase_auth/firebase_auth.dart';
import 'TermsOfService_model.dart';

class TermsOfServiceViewModel {
  Future<void> assentPolicy() async {
    String? userUID = FirebaseAuth.instance.currentUser!.uid;
    DateTime now = DateTime.now();
    await TermsOfServiceModel().setUserPolicyAssent(
      uid: userUID,
      assentTime: now,
    );
  }
}
