import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:loaduo/ViewPage/GganbuPage/FindStatic/FindStatic_provider.dart';
import 'package:loaduo/lostark_info.dart';

class ServerDrawer extends ConsumerStatefulWidget {
  final bottomController;
  const ServerDrawer({super.key, required this.bottomController});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ServerDrawerState();
}

class _ServerDrawerState extends ConsumerState<ServerDrawer> {
  @override
  Widget build(BuildContext context) {
    final server = ref.watch(staticServerFilter);
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
                      ref.read(staticServerFilter.notifier).update(null);
                    } else {
                      ref.read(staticServerFilter.notifier).update(serverName);
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
                ref.read(staticRaidFilter.notifier).update(null);
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
                          ref.read(staticRaidFilter.notifier).update(
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
                          ref.read(staticRaidFilter.notifier).update(
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
                          ref.read(staticRaidFilter.notifier).update(
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
