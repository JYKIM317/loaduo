import 'package:flutter_riverpod/flutter_riverpod.dart';

final apikey = StateNotifierProvider<ApikeyNotifier, String>((ref) {
  return ApikeyNotifier();
});

class ApikeyNotifier extends StateNotifier<String> {
  ApikeyNotifier() : super('null');

  update(String apikey) {
    //final SharedPreferences prefs = await SharedPreferences.getInstance();
    //await prefs.setString('apikey', apikey);
    state = apikey;
  }
}

final initialDataExist =
    StateNotifierProvider<InitialDataNotifier, bool>((ref) {
  return InitialDataNotifier();
});

class InitialDataNotifier extends StateNotifier<bool> {
  InitialDataNotifier() : super(false);

  existTrue() {
    //final SharedPreferences prefs = await SharedPreferences.getInstance();
    //await prefs.setString('apikey', apikey);
    state = true;
  }

  existFalse() {
    //final SharedPreferences prefs = await SharedPreferences.getInstance();
    //await prefs.setString('apikey', apikey);
    state = false;
  }
}
