import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchString = StateNotifierProvider<SearchStringNotifier, String>((ref) {
  return SearchStringNotifier();
});

class SearchStringNotifier extends StateNotifier<String> {
  SearchStringNotifier() : super('');

  update(String value) {
    state = value;
  }
}

/*
final searchHistory =
    StateNotifierProvider<SearchHistoryNotifier, List<dynamic>>((ref) {
  return SearchHistoryNotifier();
});

class SearchHistoryNotifier extends StateNotifier<List<dynamic>> {
  SearchHistoryNotifier() : super([]);

  update(List<dynamic> history) {
    state.addAll(history);
  }

  remove(int index) {
    state.removeAt(index);
  }
}
*/