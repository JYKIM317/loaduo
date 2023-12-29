import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddMyCharacterModel {
  Future<dynamic> getUserSiblingsDataAPI({required String userName}) async {
    String apiRequestUrl =
        'https://developer-lostark.game.onstove.com/characters/$userName/siblings';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? myAPIKey = prefs.getString('apikey');
    if (myAPIKey == null) {
      return null;
    }
    var response = await http.get(Uri.parse(apiRequestUrl), headers: {
      'accept': 'application/json',
      'authorization': 'bearer $myAPIKey',
    });
    return response;
  }

  Future<void> updateMyCharacter({required Map<String, dynamic> data}) async {
    String? userUID = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(userUID)
        .update(data);
  }
}
