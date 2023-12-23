import 'package:flutter_riverpod/flutter_riverpod.dart';

final mainpageIndex = StateNotifierProvider<MainPageIndexNotifier, int>((ref) {
  return MainPageIndexNotifier();
});

class MainPageIndexNotifier extends StateNotifier<int> {
  MainPageIndexNotifier() : super(0);

  update(int data) {
    state = data;
  }
}
