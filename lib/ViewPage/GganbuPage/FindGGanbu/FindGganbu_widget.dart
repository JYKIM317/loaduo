import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:loaduo/ViewPage/GganbuPage/FindGGanbu/FindGganbu_provider.dart';
import 'package:loaduo/lostark_info.dart';
import 'package:loaduo/ShowToastMsg.dart';

class ServerDrawer extends ConsumerStatefulWidget {
  final bottomController;
  const ServerDrawer({super.key, required this.bottomController});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ServerDrawerState();
}

class _ServerDrawerState extends ConsumerState<ServerDrawer> {
  @override
  Widget build(BuildContext context) {
    final server = ref.watch(gganbuServerFilter);
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.only(bottom: 34.h),
              itemCount: lostarkInfo().serverList.length,
              itemBuilder: (BuildContext ctx, int idx) {
                String serverName = lostarkInfo().serverList[idx];
                return TextButton(
                  onPressed: () {
                    if (serverName == '전체') {
                      ref.read(gganbuServerFilter.notifier).update(null);
                    } else {
                      ref.read(gganbuServerFilter.notifier).update(serverName);
                    }
                    widget.bottomController.close();
                  },
                  child: Text(
                    serverName,
                    style: TextStyle(
                      color: server == serverName
                          ? Colors.deepOrange[400]
                          : Colors.black,
                      fontSize: 24.sp,
                    ),
                  ),
                );
              },
              separatorBuilder: (ctx, idx) {
                return SizedBox(height: 10.h);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TypeDrawer extends ConsumerStatefulWidget {
  final bottomController;
  const TypeDrawer({super.key, required this.bottomController});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TypeDrawerState();
}

class _TypeDrawerState extends ConsumerState<TypeDrawer> {
  List<String> typeList = ['전체', '레이드', '내실', '일일 숙제'];
  List<String> selectedTypes = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.only(bottom: 34.h),
              itemCount: typeList.length,
              itemBuilder: (BuildContext ctx, int idx) {
                String typeElement = typeList[idx];
                return TextButton(
                  onPressed: () {
                    if (typeElement == '전체') {
                      selectedTypes.clear();
                      ref.read(gganbuTypeFilter.notifier).clear();
                      widget.bottomController.close();
                    } else {
                      if (selectedTypes.contains(typeElement)) {
                        selectedTypes.remove(typeElement);
                      } else {
                        selectedTypes.add(typeElement);
                      }

                      if (selectedTypes.isEmpty) {
                        ref.read(gganbuTypeFilter.notifier).clear();
                      } else {
                        ref.read(gganbuTypeFilter.notifier).clear();
                        ref
                            .read(gganbuTypeFilter.notifier)
                            .update(selectedTypes);
                        if (selectedTypes.length == 3) {
                          widget.bottomController.close();
                        }
                      }
                    }
                  },
                  child: Text(
                    typeElement,
                    style: TextStyle(
                      color: selectedTypes.contains(typeElement)
                          ? Colors.deepOrange[400]
                          : Colors.black,
                      fontSize: 24.sp,
                    ),
                  ),
                );
              },
              separatorBuilder: (ctx, idx) {
                return SizedBox(height: 10.h);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class WeekdayDrawer extends ConsumerStatefulWidget {
  final bottomController;
  const WeekdayDrawer({super.key, required this.bottomController});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WeekdayDrawerState();
}

class _WeekdayDrawerState extends ConsumerState<WeekdayDrawer> {
  List<String> dayHalf = ['AM', 'PM'];
  List<int> hour = [12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
  String currentDayHalf = 'PM';
  int currentShour = 7;
  int currentEhour = 12;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 34.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 60.w,
                  height: double.infinity,
                  alignment: Alignment.center,
                  child: PageView.builder(
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    pageSnapping: true,
                    controller: PageController(
                      initialPage: 1,
                      viewportFraction: 0.1,
                    ),
                    onPageChanged: (int index) {
                      setState(() {
                        currentDayHalf = dayHalf[index];
                      });
                    },
                    itemCount: dayHalf.length,
                    itemBuilder: (BuildContext ctx, int idx) {
                      return Text(
                        dayHalf[idx].toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: currentDayHalf == dayHalf[idx]
                              ? Colors.black
                              : Colors.grey[400],
                          fontSize: 24.sp,
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  width: 60.w,
                  height: double.infinity,
                  alignment: Alignment.center,
                  child: PageView.builder(
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    pageSnapping: true,
                    controller: PageController(
                      initialPage: currentShour,
                      viewportFraction: 0.1,
                    ),
                    onPageChanged: (int index) {
                      setState(() {
                        currentShour = hour[index];
                      });
                    },
                    itemCount: hour.length,
                    itemBuilder: (BuildContext ctx, int idx) {
                      return Text(
                        hour[idx].toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: currentShour == hour[idx]
                              ? Colors.black
                              : Colors.grey[400],
                          fontSize: 24.sp,
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  width: 60.w,
                  alignment: Alignment.center,
                  child: Text(
                    '~',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.sp,
                    ),
                  ),
                ),
                Container(
                  width: 60.w,
                  height: double.infinity,
                  alignment: Alignment.center,
                  child: PageView.builder(
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    pageSnapping: true,
                    controller: PageController(
                      initialPage: currentEhour,
                      viewportFraction: 0.1,
                    ),
                    onPageChanged: (int index) {
                      setState(() {
                        currentEhour = hour[index];
                      });
                    },
                    itemCount: hour.length,
                    itemBuilder: (BuildContext ctx, int idx) {
                      return Text(
                        hour[idx].toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: currentEhour == hour[idx]
                              ? Colors.black
                              : Colors.grey[400],
                          fontSize: 24.sp,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              int selectSHour = currentShour;
              int selectEHour = currentEhour;
              if (currentDayHalf == 'PM') {
                if (selectSHour != 12) {
                  selectSHour += 12;
                }
                if (selectEHour != 12) {
                  selectEHour += 12;
                }
              } else {
                if (selectSHour == 12) {
                  selectSHour -= 12;
                }
                if (selectEHour == 12) {
                  selectEHour -= 12;
                }
              }
              if (selectSHour > selectEHour) {
                showToast('시간 범위가 잘못되었습니다.');
              } else {
                ref.read(gganbuWeekDaySFilter.notifier).update(selectSHour);
                ref.read(gganbuWeekDayEFilter.notifier).update(selectEHour);
                widget.bottomController.close();
              }
            },
            child: Container(
              width: double.infinity,
              height: 80.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.sp),
                color: Colors.deepOrange[400],
              ),
              child: Text(
                '필터 적용하기',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WeekendDrawer extends ConsumerStatefulWidget {
  final bottomController;
  const WeekendDrawer({super.key, required this.bottomController});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WeekendDrawerState();
}

class _WeekendDrawerState extends ConsumerState<WeekendDrawer> {
  List<String> dayHalf = ['AM', 'PM'];
  List<int> hour = [12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
  String currentDayHalf = 'PM';
  int currentShour = 1;
  int currentEhour = 6;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 34.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 60.w,
                  height: double.infinity,
                  alignment: Alignment.center,
                  child: PageView.builder(
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    pageSnapping: true,
                    controller: PageController(
                      initialPage: 1,
                      viewportFraction: 0.1,
                    ),
                    onPageChanged: (int index) {
                      setState(() {
                        currentDayHalf = dayHalf[index];
                      });
                    },
                    itemCount: dayHalf.length,
                    itemBuilder: (BuildContext ctx, int idx) {
                      return Text(
                        dayHalf[idx].toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: currentDayHalf == dayHalf[idx]
                              ? Colors.black
                              : Colors.grey[400],
                          fontSize: 24.sp,
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  width: 60.w,
                  height: double.infinity,
                  alignment: Alignment.center,
                  child: PageView.builder(
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    pageSnapping: true,
                    controller: PageController(
                      initialPage: currentShour,
                      viewportFraction: 0.1,
                    ),
                    onPageChanged: (int index) {
                      setState(() {
                        currentShour = hour[index];
                      });
                    },
                    itemCount: hour.length,
                    itemBuilder: (BuildContext ctx, int idx) {
                      return Text(
                        hour[idx].toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: currentShour == hour[idx]
                              ? Colors.black
                              : Colors.grey[400],
                          fontSize: 24.sp,
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  width: 60.w,
                  alignment: Alignment.center,
                  child: Text(
                    '~',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.sp,
                    ),
                  ),
                ),
                Container(
                  width: 60.w,
                  height: double.infinity,
                  alignment: Alignment.center,
                  child: PageView.builder(
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    pageSnapping: true,
                    controller: PageController(
                      initialPage: currentEhour,
                      viewportFraction: 0.1,
                    ),
                    onPageChanged: (int index) {
                      setState(() {
                        currentEhour = hour[index];
                      });
                    },
                    itemCount: hour.length,
                    itemBuilder: (BuildContext ctx, int idx) {
                      return Text(
                        hour[idx].toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: currentEhour == hour[idx]
                              ? Colors.black
                              : Colors.grey[400],
                          fontSize: 24.sp,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              int selectSHour = currentShour;
              int selectEHour = currentEhour;
              if (currentDayHalf == 'PM') {
                if (selectSHour != 12) {
                  selectSHour += 12;
                }
                if (selectEHour != 12) {
                  selectEHour += 12;
                }
              } else {
                if (selectSHour == 12) {
                  selectSHour -= 12;
                }
                if (selectEHour == 12) {
                  selectEHour -= 12;
                }
              }
              if (selectSHour > selectEHour) {
                showToast('시간 범위가 잘못되었습니다.');
              } else {
                ref.read(gganbuWeekEndSFilter.notifier).update(selectSHour);
                ref.read(gganbuWeekEndEFilter.notifier).update(selectEHour);
                widget.bottomController.close();
              }
            },
            child: Container(
              width: double.infinity,
              height: 80.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.sp),
                color: Colors.deepOrange[400],
              ),
              child: Text(
                '필터 적용하기',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
