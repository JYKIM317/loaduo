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

  remove() {
    state.clear();
  }
}

final myPageCharacter =
    StateNotifierProvider<MyPageCharacterNotifier, List<dynamic>>((ref) {
  return MyPageCharacterNotifier();
});

class MyPageCharacterNotifier extends StateNotifier<List<dynamic>> {
  MyPageCharacterNotifier() : super([]);

  update({
    required List<dynamic> data,
  }) {
    state.addAll(data);
  }

  remove() {
    state.clear();
  }
}
