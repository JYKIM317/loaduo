import 'SearchUserPage_model.dart';
import 'dart:convert';

class SearchUserPageViewModel {
  Future<Map<String, dynamic>?> searchUser({required String userName}) async {
    List<dynamic> mySearchHistory =
        await SearchUserPageModel().getSearchHistoryData();
    if (mySearchHistory.contains(userName)) {
      int index = mySearchHistory.indexOf(userName);
      mySearchHistory.removeAt(index);
      mySearchHistory.add(userName);
    } else {
      if (mySearchHistory.length >= 10) {
        mySearchHistory.removeAt(0);
      }
      mySearchHistory.add(userName);
    }
    await SearchUserPageModel().saveSearchHistoryData(
        searchHistoryData: mySearchHistory as List<String>);

    var response =
        await SearchUserPageModel().getUserDataAPI(userName: userName);

    int statusCode;
    if (response != null) {
      statusCode = response.statusCode;
    } else {
      statusCode = 401;
    }

    var body;
    if (statusCode == 200) {
      body = jsonDecode(response.body);
    }
    Map<String, dynamic> responseData = {
      'statusCode': statusCode,
      'body': body,
    };
    return responseData;
  }

  Future<List<dynamic>> getSearchHistory() async {
    List<dynamic> mySearchHistory =
        await SearchUserPageModel().getSearchHistoryData();
    mySearchHistory = mySearchHistory.reversed.toList();
    return mySearchHistory;
  }

  Future<void> deleteSearchHistory(int index) async {
    List<dynamic> mySearchHistory =
        await SearchUserPageModel().getSearchHistoryData();
    mySearchHistory = mySearchHistory.reversed.toList();
    mySearchHistory.removeAt(index);
    mySearchHistory = mySearchHistory.reversed.toList();
    SearchUserPageModel().saveSearchHistoryData(
        searchHistoryData: mySearchHistory as List<String>);
  }
}
