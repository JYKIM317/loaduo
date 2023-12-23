import 'package:shared_preferences/shared_preferences.dart';

class ApiDataModel {
  Future<void> saveApiKeyToLocal(String apikey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('apikey', apikey);
  }
}
