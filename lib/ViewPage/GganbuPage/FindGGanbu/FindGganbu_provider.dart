import 'package:flutter_riverpod/flutter_riverpod.dart';

final gganbuFilterIndex =
    StateNotifierProvider<GganbuFilterIndexNotifier, int>((ref) {
  return GganbuFilterIndexNotifier();
});

class GganbuFilterIndexNotifier extends StateNotifier<int> {
  GganbuFilterIndexNotifier() : super(0);

  update(int index) {
    state = index;
  }
}

final gganbuServerFilter =
    StateNotifierProvider<GganbuServerFilterNotifier, String?>((ref) {
  return GganbuServerFilterNotifier();
});

class GganbuServerFilterNotifier extends StateNotifier<String?> {
  GganbuServerFilterNotifier() : super(null);

  update(String? server) {
    state = server;
  }
}

final gganbuTypeFilter =
    StateNotifierProvider<GganbuTypeFilterNotifier, List<String>?>((ref) {
  return GganbuTypeFilterNotifier();
});

class GganbuTypeFilterNotifier extends StateNotifier<List<String>?> {
  GganbuTypeFilterNotifier() : super(null);

  clear() {
    state = null;
  }

  update(List<String> type) {
    state = type;
  }
}

final gganbuWeekDaySFilter =
    StateNotifierProvider<GganbuWeekDaySFilterNotifier, int?>((ref) {
  return GganbuWeekDaySFilterNotifier();
});

class GganbuWeekDaySFilterNotifier extends StateNotifier<int?> {
  GganbuWeekDaySFilterNotifier() : super(null);

  update(int? hour) {
    state = hour;
  }
}

final gganbuWeekDayEFilter =
    StateNotifierProvider<GganbuWeekDayEFilterNotifier, int?>((ref) {
  return GganbuWeekDayEFilterNotifier();
});

class GganbuWeekDayEFilterNotifier extends StateNotifier<int?> {
  GganbuWeekDayEFilterNotifier() : super(null);

  update(int? hour) {
    state = hour;
  }
}

final gganbuWeekEndSFilter =
    StateNotifierProvider<GganbuWeekEndSFilterNotifier, int?>((ref) {
  return GganbuWeekEndSFilterNotifier();
});

class GganbuWeekEndSFilterNotifier extends StateNotifier<int?> {
  GganbuWeekEndSFilterNotifier() : super(null);

  update(int? hour) {
    state = hour;
  }
}

final gganbuWeekEndEFilter =
    StateNotifierProvider<GganbuWeekEndEFilterNotifier, int?>((ref) {
  return GganbuWeekEndEFilterNotifier();
});

class GganbuWeekEndEFilterNotifier extends StateNotifier<int?> {
  GganbuWeekEndEFilterNotifier() : super(null);

  update(int? hour) {
    state = hour;
  }
}
