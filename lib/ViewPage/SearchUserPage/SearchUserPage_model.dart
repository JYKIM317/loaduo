import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SearchUserPageModel {
  Future<void> saveSearchHistoryData(
      {required List<String> searchHistoryData}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('searchHistory', searchHistoryData);
  }

  Future<List<dynamic>> getSearchHistoryData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> searchHistory = prefs.getStringList('searchHistory') ?? [];
    return searchHistory;
  }

  Future<dynamic> getUserDataAPI({required String userName}) async {
    String apiRequestUrl =
        'https://developer-lostark.game.onstove.com/armories/characters/$userName?filters=profiles%2Bcards%2Bgems%2Bengravings%2Bequipment';
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
}
