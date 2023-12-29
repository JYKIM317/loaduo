import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchMyCharString =
    StateNotifierProvider<SearchMyCharStringNotifier, String>((ref) {
  return SearchMyCharStringNotifier();
});

class SearchMyCharStringNotifier extends StateNotifier<String> {
  SearchMyCharStringNotifier() : super('');

  update(String value) {
    state = value;
  }
}
