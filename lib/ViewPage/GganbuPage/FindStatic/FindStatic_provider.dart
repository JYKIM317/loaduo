import 'package:flutter_riverpod/flutter_riverpod.dart';

final staticFilterIndex =
    StateNotifierProvider<StaticFilterIndexNotifier, int>((ref) {
  return StaticFilterIndexNotifier();
});

class StaticFilterIndexNotifier extends StateNotifier<int> {
  StaticFilterIndexNotifier() : super(0);

  update(int index) {
    state = index;
  }
}

final staticRaidFilter =
    StateNotifierProvider<StaticRaidFilterNotifier, String?>((ref) {
  return StaticRaidFilterNotifier();
});

class StaticRaidFilterNotifier extends StateNotifier<String?> {
  StaticRaidFilterNotifier() : super(null);

  update(String? raid) {
    state = raid;
  }
}
