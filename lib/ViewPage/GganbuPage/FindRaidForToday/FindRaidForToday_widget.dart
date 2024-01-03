import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:loaduo/ViewPage/GganbuPage/FindRaidForToday/FindRaidForToday_provider.dart';
import 'package:loaduo/lostark_info.dart';
import 'package:loaduo/ShowToastMsg.dart';

class RaidDrawer extends ConsumerStatefulWidget {
  final bottomController;
  const RaidDrawer({super.key, required this.bottomController});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RaidDrawerState();
}

class _RaidDrawerState extends ConsumerState<RaidDrawer> {
  bool legionRaidSelect = false;
  String? legeionElement;
  bool abyssDungeonSelect = false;
  String? abyssElement;
  bool kazerosRaidSelect = false;
  String? kazerosElement;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 0),
      child: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 34.h),
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              onPressed: () {
                ref.read(raidForTodayRaidFilter.notifier).update(null);
                widget.bottomController.close();
              },
              child: Text(
                '전체',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24.sp,
                ),
              ),
            ),
            //군단장 레이드
            TextButton(
              onPressed: () {
                setState(() {
                  legionRaidSelect
                      ? legionRaidSelect = false
                      : legionRaidSelect = true;
                });
              },
              child: Text(
                '군단장 레이드',
                style: TextStyle(
                  color:
                      legionRaidSelect ? Colors.deepOrange[400] : Colors.black,
                  fontSize: 24.sp,
                ),
              ),
            ),
            if (legionRaidSelect)
              Padding(
                padding: EdgeInsets.only(left: 16.w),
                child: SizedBox(
                  height: 60.h,
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: lostarkInfo().legionRaidList.length,
                    itemBuilder: (BuildContext ctx, int idx) {
                      return TextButton(
                        onPressed: () {
                          setState(() {
                            if (legeionElement ==
                                lostarkInfo().legionRaidList[idx]) {
                              legeionElement = null;
                            } else {
                              legeionElement =
                                  lostarkInfo().legionRaidList[idx];
                            }
                          });
                        },
                        child: Text(
                          lostarkInfo().legionRaidList[idx],
                          style: TextStyle(
                            color: legeionElement ==
                                    lostarkInfo().legionRaidList[idx]
                                ? Colors.deepOrange[400]
                                : Colors.black,
                            fontSize: 24.sp,
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (ctx, idx) {
                      return SizedBox(width: 10.w);
                    },
                  ),
                ),
              ),
            if (legionRaidSelect && legeionElement != null)
              Padding(
                padding: EdgeInsets.only(left: 32.w),
                child: SizedBox(
                  height: 60.h,
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount:
                        lostarkInfo().raidDifficulty[legeionElement].length,
                    itemBuilder: (BuildContext ctx, int idx) {
                      return TextButton(
                        onPressed: () {
                          ref.read(raidForTodayRaidFilter.notifier).update(
                              '$legeionElement ${lostarkInfo().raidDifficulty[legeionElement][idx]}');
                          widget.bottomController.close();
                        },
                        child: Text(
                          lostarkInfo().raidDifficulty[legeionElement][idx],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24.sp,
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (ctx, idx) {
                      return SizedBox(width: 10.w);
                    },
                  ),
                ),
              ),
            //어비스 던전
            TextButton(
              onPressed: () {
                setState(() {
                  abyssDungeonSelect
                      ? abyssDungeonSelect = false
                      : abyssDungeonSelect = true;
                });
              },
              child: Text(
                '어비스 던전',
                style: TextStyle(
                  color: abyssDungeonSelect
                      ? Colors.deepOrange[400]
                      : Colors.black,
                  fontSize: 24.sp,
                ),
              ),
            ),
            if (abyssDungeonSelect)
              Padding(
                padding: EdgeInsets.only(left: 16.w),
                child: SizedBox(
                  height: 60.h,
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: lostarkInfo().abyssDungeonList.length,
                    itemBuilder: (BuildContext ctx, int idx) {
                      return TextButton(
                        onPressed: () {
                          setState(() {
                            if (abyssElement ==
                                lostarkInfo().abyssDungeonList[idx]) {
                              abyssElement = null;
                            } else {
                              abyssElement =
                                  lostarkInfo().abyssDungeonList[idx];
                            }
                          });
                        },
                        child: Text(
                          lostarkInfo().abyssDungeonList[idx],
                          style: TextStyle(
                            color: abyssElement ==
                                    lostarkInfo().abyssDungeonList[idx]
                                ? Colors.deepOrange[400]
                                : Colors.black,
                            fontSize: 24.sp,
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (ctx, idx) {
                      return SizedBox(width: 10.w);
                    },
                  ),
                ),
              ),
            if (abyssDungeonSelect && abyssElement != null)
              Padding(
                padding: EdgeInsets.only(left: 32.w),
                child: SizedBox(
                  height: 60.h,
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount:
                        lostarkInfo().raidDifficulty[abyssElement].length,
                    itemBuilder: (BuildContext ctx, int idx) {
                      return TextButton(
                        onPressed: () {
                          ref.read(raidForTodayRaidFilter.notifier).update(
                              '$abyssElement ${lostarkInfo().raidDifficulty[abyssElement][idx]}');
                          widget.bottomController.close();
                        },
                        child: Text(
                          lostarkInfo().raidDifficulty[abyssElement][idx],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24.sp,
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (ctx, idx) {
                      return SizedBox(width: 10.w);
                    },
                  ),
                ),
              ),
            //카제로스 레이드
            TextButton(
              onPressed: () {
                setState(() {
                  kazerosRaidSelect
                      ? kazerosRaidSelect = false
                      : kazerosRaidSelect = true;
                });
              },
              child: Text(
                '카제로스 레이드',
                style: TextStyle(
                  color:
                      kazerosRaidSelect ? Colors.deepOrange[400] : Colors.black,
                  fontSize: 24.sp,
                ),
              ),
            ),
            if (kazerosRaidSelect)
              Padding(
                padding: EdgeInsets.only(left: 16.w),
                child: SizedBox(
                  height: 60.h,
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: lostarkInfo().kazerosRaidList.length,
                    itemBuilder: (BuildContext ctx, int idx) {
                      return TextButton(
                        onPressed: () {
                          setState(() {
                            if (kazerosElement ==
                                lostarkInfo().kazerosRaidList[idx]) {
                              kazerosElement = null;
                            } else {
                              kazerosElement =
                                  lostarkInfo().kazerosRaidList[idx];
                            }
                          });
                        },
                        child: Text(
                          lostarkInfo().kazerosRaidList[idx],
                          style: TextStyle(
                            color: kazerosElement ==
                                    lostarkInfo().kazerosRaidList[idx]
                                ? Colors.deepOrange[400]
                                : Colors.black,
                            fontSize: 24.sp,
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (ctx, idx) {
                      return SizedBox(width: 10.w);
                    },
                  ),
                ),
              ),
            if (kazerosRaidSelect && kazerosElement != null)
              Padding(
                padding: EdgeInsets.only(left: 32.w),
                child: SizedBox(
                  height: 60.h,
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount:
                        lostarkInfo().raidDifficulty[kazerosElement].length,
                    itemBuilder: (BuildContext ctx, int idx) {
                      return TextButton(
                        onPressed: () {
                          ref.read(raidForTodayRaidFilter.notifier).update(
                              '$kazerosElement ${lostarkInfo().raidDifficulty[kazerosElement][idx]}');
                          widget.bottomController.close();
                        },
                        child: Text(
                          lostarkInfo().raidDifficulty[kazerosElement][idx],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24.sp,
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (ctx, idx) {
                      return SizedBox(width: 10.w);
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class SkillDrawer extends ConsumerStatefulWidget {
  final bottomController;
  const SkillDrawer({super.key, required this.bottomController});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SkillDrawerState();
}

class _SkillDrawerState extends ConsumerState<SkillDrawer> {
  List<String> skillList = ['전체', '숙련', '반숙', '클경', '트라이'];
  @override
  Widget build(BuildContext context) {
    final skill = ref.watch(raidForTodaySkillFilter);
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
              itemCount: skillList.length,
              itemBuilder: (BuildContext ctx, int idx) {
                String skillName = skillList[idx];
                return TextButton(
                  onPressed: () {
                    if (skillName == '전체') {
                      ref.read(raidForTodaySkillFilter.notifier).update(null);
                    } else {
                      ref
                          .read(raidForTodaySkillFilter.notifier)
                          .update(skillName);
                    }
                    widget.bottomController.close();
                  },
                  child: Text(
                    skillName,
                    style: TextStyle(
                      color: skill == skillName
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

class TimeDrawer extends ConsumerStatefulWidget {
  final bottomController;
  const TimeDrawer({super.key, required this.bottomController});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TimeDrawerState();
}

class _TimeDrawerState extends ConsumerState<TimeDrawer> {
  List<String> dayHalf = ['AM', 'PM'];
  List<int> hour = [12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
  List<int> minute = [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55];
  String sDayHalf = 'PM', eDayHalf = 'PM';
  int sHour = 2, sMinute = 30, eHour = 5, eMinute = 30;

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
                      viewportFraction: 0.3,
                    ),
                    onPageChanged: (int index) {
                      setState(() {
                        sDayHalf = dayHalf[index];
                      });
                    },
                    itemCount: dayHalf.length,
                    itemBuilder: (BuildContext ctx, int idx) {
                      return Text(
                        dayHalf[idx].toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: sDayHalf == dayHalf[idx]
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
                      initialPage: sHour,
                      viewportFraction: 0.3,
                    ),
                    onPageChanged: (int index) {
                      setState(() {
                        sHour = hour[index];
                      });
                    },
                    itemCount: hour.length,
                    itemBuilder: (BuildContext ctx, int idx) {
                      return Text(
                        hour[idx].toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: sHour == hour[idx]
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
                    ':',
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
                      initialPage: 6,
                      viewportFraction: 0.3,
                    ),
                    onPageChanged: (int index) {
                      setState(() {
                        sMinute = minute[index];
                      });
                    },
                    itemCount: minute.length,
                    itemBuilder: (BuildContext ctx, int idx) {
                      return Text(
                        minute[idx].toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: sMinute == minute[idx]
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
                    '부터',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey[300],
            thickness: 2.h,
            height: 40.h,
          ),
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
                      viewportFraction: 0.3,
                    ),
                    onPageChanged: (int index) {
                      setState(() {
                        eDayHalf = dayHalf[index];
                      });
                    },
                    itemCount: dayHalf.length,
                    itemBuilder: (BuildContext ctx, int idx) {
                      return Text(
                        dayHalf[idx].toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: eDayHalf == dayHalf[idx]
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
                      initialPage: eHour,
                      viewportFraction: 0.3,
                    ),
                    onPageChanged: (int index) {
                      setState(() {
                        eHour = hour[index];
                      });
                    },
                    itemCount: hour.length,
                    itemBuilder: (BuildContext ctx, int idx) {
                      return Text(
                        hour[idx].toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: eHour == hour[idx]
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
                    ':',
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
                      initialPage: 6,
                      viewportFraction: 0.3,
                    ),
                    onPageChanged: (int index) {
                      setState(() {
                        eMinute = minute[index];
                      });
                    },
                    itemCount: minute.length,
                    itemBuilder: (BuildContext ctx, int idx) {
                      return Text(
                        minute[idx].toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: eMinute == minute[idx]
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
                    '까지',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              final today = DateTime.now();
              int selectSHour = sHour,
                  selectSMinute = sMinute,
                  selectEHour = eHour,
                  selectEMinute = eMinute;
              if (sDayHalf == 'PM') {
                if (selectSHour != 12) {
                  selectSHour += 12;
                }
              } else {
                if (selectSHour == 12) {
                  selectSHour -= 12;
                }
              }
              if (eDayHalf == 'PM') {
                if (selectEHour != 12) {
                  selectEHour += 12;
                }
              } else {
                if (selectEHour == 12) {
                  selectEHour -= 12;
                }
              }
              DateTime sTime = DateTime(today.year, today.month, today.day,
                  selectSHour, selectSMinute, 0);
              DateTime eTime = DateTime(today.year, today.month, today.day,
                  selectEHour, selectEMinute, 50);
              if (!sTime.isBefore(eTime)) {
                showToast('시간 범위가 잘못되었습니다.');
              } else {
                if (selectSHour == 0 &&
                    selectSMinute == 0 &&
                    selectEHour == 23 &&
                    selectEMinute == 55) {
                  ref.read(raidForTodaySFilter.notifier).update(null);
                  ref.read(raidForTodayEFilter.notifier).update(null);
                  widget.bottomController.close();
                } else {
                  ref.read(raidForTodaySFilter.notifier).update(sTime);
                  ref.read(raidForTodayEFilter.notifier).update(eTime);
                  widget.bottomController.close();
                }
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
