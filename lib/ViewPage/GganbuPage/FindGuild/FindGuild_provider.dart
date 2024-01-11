import 'package:flutter_riverpod/flutter_riverpod.dart';

final guildFilterIndex =
    StateNotifierProvider<GuildFilterIndexNotifier, int>((ref) {
  return GuildFilterIndexNotifier();
});

class GuildFilterIndexNotifier extends StateNotifier<int> {
  GuildFilterIndexNotifier() : super(0);

  update(int index) {
    state = index;
  }
}

final guildServerFilter =
    StateNotifierProvider<GuildServerFilterNotifier, String?>((ref) {
  return GuildServerFilterNotifier();
});

class GuildServerFilterNotifier extends StateNotifier<String?> {
  GuildServerFilterNotifier() : super(null);

  update(String? server) {
    state = server;
  }
}

final guildTypeFilter =
    StateNotifierProvider<GuildTypeFilterNotifier, String?>((ref) {
  return GuildTypeFilterNotifier();
});

class GuildTypeFilterNotifier extends StateNotifier<String?> {
  GuildTypeFilterNotifier() : super(null);

  update(String? type) {
    state = type;
  }
}

final guildLevelFilter =
    StateNotifierProvider<GuildLevelFilterNotifier, int?>((ref) {
  return GuildLevelFilterNotifier();
});

class GuildLevelFilterNotifier extends StateNotifier<int?> {
  GuildLevelFilterNotifier() : super(null);

  update(int? level) {
    state = level;
  }
}
