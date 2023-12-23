import 'package:flutter_riverpod/flutter_riverpod.dart';

final initialDataIndex =
    StateNotifierProvider<InitialIndexNotifier, int>((ref) {
  return InitialIndexNotifier();
});

class InitialIndexNotifier extends StateNotifier<int> {
  InitialIndexNotifier() : super(0);
  page1() {
    state = 1;
  }

  page2() {
    state = 2;
  }
}

/////////////////////////////////////////////

final bossraid = StateNotifierProvider<BossraidNotifier, bool>((ref) {
  return BossraidNotifier();
});

class BossraidNotifier extends StateNotifier<bool> {
  BossraidNotifier() : super(false);

  selectTrue() {
    state = true;
  }

  selectFalse() {
    state = false;
  }
}

final adventure = StateNotifierProvider<AdventureNotifier, bool>((ref) {
  return AdventureNotifier();
});

class AdventureNotifier extends StateNotifier<bool> {
  AdventureNotifier() : super(false);

  selectTrue() {
    state = true;
  }

  selectFalse() {
    state = false;
  }
}

final homework = StateNotifierProvider<HomeworkNotifier, bool>((ref) {
  return HomeworkNotifier();
});

class HomeworkNotifier extends StateNotifier<bool> {
  HomeworkNotifier() : super(false);

  selectTrue() {
    state = true;
  }

  selectFalse() {
    state = false;
  }
}
/////////////////////////////////////////////

final yourmood = StateNotifierProvider<MoodNotifier, int>((ref) {
  return MoodNotifier();
});

class MoodNotifier extends StateNotifier<int> {
  MoodNotifier() : super(0);

  select0() {
    state = 0;
  }

  select1() {
    state = 1;
  }
}

final yourdistribute = StateNotifierProvider<DistributeNotifier, int>((ref) {
  return DistributeNotifier();
});

class DistributeNotifier extends StateNotifier<int> {
  DistributeNotifier() : super(0);

  select0() {
    state = 0;
  }

  select1() {
    state = 1;
  }
}

final yourskill = StateNotifierProvider<SkillNotifier, int>((ref) {
  return SkillNotifier();
});

class SkillNotifier extends StateNotifier<int> {
  SkillNotifier() : super(0);

  select0() {
    state = 0;
  }

  select1() {
    state = 1;
  }

  select2() {
    state = 2;
  }

  select3() {
    state = 3;
  }
}

/////////////////////////////////////////////

final weekdayPlaytime = StateNotifierProvider<WeekDayNotifier, int>((ref) {
  return WeekDayNotifier();
});

class WeekDayNotifier extends StateNotifier<int> {
  WeekDayNotifier() : super(20);

  update(int data) {
    state = data;
  }
}

final weekendPlaytime = StateNotifierProvider<WeekEndNotifier, int>((ref) {
  return WeekEndNotifier();
});

class WeekEndNotifier extends StateNotifier<int> {
  WeekEndNotifier() : super(13);

  update(int data) {
    state = data;
  }
}
