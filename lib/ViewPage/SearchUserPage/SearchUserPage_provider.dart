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
