import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InitialDataModel {
  Future<void> updateMyInfo({required Map<String, dynamic> data}) async {
    String? userUID = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(userUID)
        .update(data);
  }

  Future<void> updateInitialDataExist() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('initialdata', true);
  }
}
