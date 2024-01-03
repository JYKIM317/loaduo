import 'package:flutter_riverpod/flutter_riverpod.dart';

final raidForTodayListDataLength =
    StateNotifierProvider<RaidForTodayDataListNotifier, int>((ref) {
  return RaidForTodayDataListNotifier();
});

class RaidForTodayDataListNotifier extends StateNotifier<int> {
  RaidForTodayDataListNotifier() : super(0);

  update(int count) {
    state = count;
  }
}

final raidForTodayFilterIndex =
    StateNotifierProvider<RaidForTodayFilterIndexNotifier, int>((ref) {
  return RaidForTodayFilterIndexNotifier();
});

class RaidForTodayFilterIndexNotifier extends StateNotifier<int> {
  RaidForTodayFilterIndexNotifier() : super(0);

  update(int index) {
    state = index;
  }
}

final raidForTodayRaidFilter =
    StateNotifierProvider<RaidForTodayRaidFilterNotifier, String?>((ref) {
  return RaidForTodayRaidFilterNotifier();
});

class RaidForTodayRaidFilterNotifier extends StateNotifier<String?> {
  RaidForTodayRaidFilterNotifier() : super(null);

  update(String? raid) {
    state = raid;
  }
}

final raidForTodaySkillFilter =
    StateNotifierProvider<RaidForTodaySkillFilterNotifier, String?>((ref) {
  return RaidForTodaySkillFilterNotifier();
});

class RaidForTodaySkillFilterNotifier extends StateNotifier<String?> {
  RaidForTodaySkillFilterNotifier() : super(null);

  update(String? skill) {
    state = skill;
  }
}

final raidForTodaySFilter =
    StateNotifierProvider<RaidForTodaySFilterNotifier, DateTime?>((ref) {
  return RaidForTodaySFilterNotifier();
});

class RaidForTodaySFilterNotifier extends StateNotifier<DateTime?> {
  RaidForTodaySFilterNotifier() : super(null);

  update(DateTime? time) {
    state = time;
  }
}

final raidForTodayEFilter =
    StateNotifierProvider<RaidForTodayEFilterNotifier, DateTime?>((ref) {
  return RaidForTodayEFilterNotifier();
});

class RaidForTodayEFilterNotifier extends StateNotifier<DateTime?> {
  RaidForTodayEFilterNotifier() : super(null);

  update(DateTime? time) {
    state = time;
  }
}
