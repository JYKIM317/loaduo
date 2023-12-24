import 'package:flutter_riverpod/flutter_riverpod.dart';

final myPageInfo =
    StateNotifierProvider<MyPageInfoNotifier, Map<String, dynamic>>((ref) {
  return MyPageInfoNotifier();
});

class MyPageInfoNotifier extends StateNotifier<Map<String, dynamic>> {
  MyPageInfoNotifier() : super({});

  update({
    required Map<String, dynamic> data,
  }) {
    state.addAll(data);
  }
}

final myPageCharacter =
    StateNotifierProvider<MyPageCharacterNotifier, Map<String, dynamic>>((ref) {
  return MyPageCharacterNotifier();
});

class MyPageCharacterNotifier extends StateNotifier<Map<String, dynamic>> {
  MyPageCharacterNotifier() : super({});

  update({
    required Map<String, dynamic> data,
  }) {
    state.addAll(data);
  }
}
