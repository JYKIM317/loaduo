import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:bottom_drawer/bottom_drawer.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:loaduo/ViewPage/GganbuPage/FindRaidForToday/CreateRaidForTodayPost/CreateRaidForTodayPost_viewmodel.dart';
import 'package:loaduo/lostark_info.dart';
import 'package:loaduo/ShowToastMsg.dart';

class CreateRaidForTodayPost extends StatefulWidget {
  final myCharacter;
  const CreateRaidForTodayPost({super.key, required this.myCharacter});

  @override
  State<CreateRaidForTodayPost> createState() => _CreateRaidForTodayPostState();
}

class _CreateRaidForTodayPostState extends State<CreateRaidForTodayPost> {
  TextEditingController detailController = TextEditingController();
  String? raid, raidElement;
  DateTime? startTime;
  String detail = '', skill = '숙련';
  int drawerIndex = 0;

  BottomDrawerController _bottomDrawerController = BottomDrawerController();

  bool legionRaidSelect = false;
  String? legeionElement;
  bool abyssDungeonSelect = false;
  String? abyssElement;
  bool kazerosRaidSelect = false;
  String? kazerosElement;
  int? raidMaxPlayer;

  List<String> skillList = ['숙련', '반숙', '클경', '트라이'];

  List<String> dayHalf = ['AM', 'PM'];
  List<int> hour = [12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11],
      minute = [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55];
  String selectedDayHalf = 'PM';
  int selectedHour = 7, selectedMinute = 30;

  late Map<String, dynamic> myCharacter;

  @override
  void initState() {
    myCharacter = widget.myCharacter;
    super.initState();
  }

  raidDrawer() {
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
                          setState(() {
                            raid =
                                '$legeionElement ${lostarkInfo().raidDifficulty[legeionElement][idx]}';
                            raidMaxPlayer =
                                lostarkInfo().raidMaxPlayer[legeionElement];
                            raidElement = legeionElement;
                          });
                          _bottomDrawerController.close();
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
            SizedBox(height: 20.h),
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
                          setState(() {
                            raid =
                                '$abyssElement ${lostarkInfo().raidDifficulty[abyssElement][idx]}';
                            raidMaxPlayer =
                                lostarkInfo().raidMaxPlayer[abyssElement];
                            raidElement = abyssElement;
                          });
                          _bottomDrawerController.close();
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
            SizedBox(height: 20.h),
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
                          setState(() {
                            raid =
                                '$kazerosElement ${lostarkInfo().raidDifficulty[kazerosElement][idx]}';
                            raidMaxPlayer =
                                lostarkInfo().raidMaxPlayer[kazerosElement];
                            raidElement = kazerosElement;
                          });
                          _bottomDrawerController.close();
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

  skillDrawer() {
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
                    setState(() {
                      skill = skillName;
                    });
                    _bottomDrawerController.close();
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

  timeDrawer() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 34.h),
      child: Material(
        color: Colors.grey[100],
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
                          selectedDayHalf = dayHalf[index];
                        });
                      },
                      itemCount: dayHalf.length,
                      itemBuilder: (BuildContext ctx, int idx) {
                        return Text(
                          dayHalf[idx].toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: selectedDayHalf == dayHalf[idx]
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
                        initialPage: selectedHour,
                        viewportFraction: 0.1,
                      ),
                      onPageChanged: (int index) {
                        setState(() {
                          selectedHour = hour[index];
                        });
                      },
                      itemCount: hour.length,
                      itemBuilder: (BuildContext ctx, int idx) {
                        return Text(
                          hour[idx].toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: selectedHour == hour[idx]
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
                        viewportFraction: 0.1,
                      ),
                      onPageChanged: (int index) {
                        setState(() {
                          selectedMinute = minute[index];
                        });
                      },
                      itemCount: minute.length,
                      itemBuilder: (BuildContext ctx, int idx) {
                        return Text(
                          minute[idx].toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: selectedMinute == minute[idx]
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
                DateTime now = DateTime.now();
                int selectSHour = selectedHour, selectSMinute = selectedMinute;
                if (selectedDayHalf == 'PM') {
                  if (selectSHour != 12) {
                    selectSHour += 12;
                  }
                } else {
                  if (selectSHour == 12) {
                    selectSHour -= 12;
                  }
                }
                DateTime sTime = DateTime(now.year, now.month, now.day,
                    selectSHour, selectSMinute, 30);

                if (sTime.isBefore(now)) {
                  showToast('현재 시간보다 이전 시간으로 설정할 수 없습니다.');
                } else {
                  setState(() {
                    startTime = sTime;
                  });
                  _bottomDrawerController.close();
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
                  '시간 변경하기',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomDrawer(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BottomDrawer(
        controller: _bottomDrawerController,
        header: const SizedBox(height: 0),
        cornerRadius: 16.sp,
        color: Colors.grey[100]!,
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            blurRadius: 1,
          )
        ],
        body: [
          raidDrawer(),
          skillDrawer(),
          timeDrawer(),
        ][drawerIndex],
        headerHeight: 0,
        drawerHeight: 472.h,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final progress = ProgressHUD.of(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        _bottomDrawerController.close();
      },
      child: Stack(
        children: [
          Scaffold(
            body: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white,
              padding: EdgeInsets.only(bottom: 34.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: SingleChildScrollView(
                        physics: const ClampingScrollPhysics(),
                        padding:
                            EdgeInsets.only(top: 64.h, left: 16.w, right: 16.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '오늘 레이드\n모집 글 등록',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 34.sp,
                              ),
                            ),
                            SizedBox(height: 30.h),
                            Text(
                              '목표',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 21.sp,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            SizedBox(
                              width: double.infinity,
                              child: Row(
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      text: '레이드',
                                      style: TextStyle(
                                        color: Colors.deepOrange[400],
                                        fontSize: 18.sp,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: ' : ',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18.sp,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '#',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 18.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 4.w),
                                  InkWell(
                                    onTap: () {
                                      FocusScope.of(context).unfocus();
                                      _bottomDrawerController.close();
                                      setState(() {
                                        drawerIndex = 0;
                                      });
                                      _bottomDrawerController.open();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.fromLTRB(
                                          8.w, 4.h, 8.w, 4.h),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.sp),
                                        color: Colors.grey,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            raid == null ? '레이드 선택' : raid!,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.sp,
                                            ),
                                          ),
                                          SizedBox(width: 4.w),
                                          Icon(
                                            Icons.arrow_drop_down_rounded,
                                            color: Colors.white,
                                            size: 24.sp,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10.h),
                            SizedBox(
                              width: double.infinity,
                              child: Row(
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      text: '숙련도',
                                      style: TextStyle(
                                        color: Colors.deepOrange[400],
                                        fontSize: 18.sp,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: ' : ',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18.sp,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '#',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 18.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 4.w),
                                  InkWell(
                                    onTap: () {
                                      FocusScope.of(context).unfocus();
                                      _bottomDrawerController.close();
                                      setState(() {
                                        drawerIndex = 1;
                                      });
                                      _bottomDrawerController.open();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.fromLTRB(
                                          8.w, 4.h, 8.w, 4.h),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.sp),
                                        color: Colors.grey,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            skill,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.sp,
                                            ),
                                          ),
                                          SizedBox(width: 4.w),
                                          Icon(
                                            Icons.arrow_drop_down_rounded,
                                            color: Colors.white,
                                            size: 24.sp,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10.h),
                            SizedBox(
                              width: double.infinity,
                              child: Row(
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      text: '출발 시간',
                                      style: TextStyle(
                                        color: Colors.deepOrange[400],
                                        fontSize: 18.sp,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: ' : ',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18.sp,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '#',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 18.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 4.w),
                                  InkWell(
                                    onTap: () {
                                      FocusScope.of(context).unfocus();
                                      _bottomDrawerController.close();
                                      setState(() {
                                        drawerIndex = 2;
                                      });
                                      _bottomDrawerController.open();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.fromLTRB(
                                          8.w, 4.h, 8.w, 4.h),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.sp),
                                        color: Colors.grey,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            startTime == null
                                                ? '출발 시간 설정'
                                                : '${startTime!.hour}시 ${startTime!.minute}분',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.sp,
                                            ),
                                          ),
                                          SizedBox(width: 4.w),
                                          Icon(
                                            Icons.arrow_drop_down_rounded,
                                            color: Colors.white,
                                            size: 24.sp,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 30.h),
                            Text(
                              '제목',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 21.sp,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.sp),
                                border: Border.all(
                                  color: Colors.grey[400]!,
                                  width: 2.sp,
                                ),
                              ),
                              child: TextField(
                                controller: detailController,
                                minLines: 2,
                                maxLines: 2,
                                onChanged: (value) {
                                  detail = value;
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '레이드 모집 제목 입력하기',
                                  hintStyle: TextStyle(color: Colors.grey[400]),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: InkWell(
                      onTap: () async {
                        if (raid != null &&
                            startTime != null &&
                            raidMaxPlayer != null &&
                            raidElement != null) {
                          DateTime now = DateTime.now();
                          if (now.isBefore(startTime!)) {
                            int myLevel = double.parse(
                                    myCharacter['ItemMaxLevel']
                                        .replaceAll(',', ''))
                                .toInt();
                            if (myLevel >= lostarkInfo().raidLevel[raid]) {
                              progress?.show();
                              await CreateRaidForTodayPostViewModel()
                                  .uploadPost(
                                raidLeader: myCharacter['uid'],
                                raid: raid!,
                                raidName: raidElement!,
                                raidMaxPlayer: raidMaxPlayer!,
                                skill: skill,
                                startTime: startTime!,
                                detail: detail,
                                myCharacter: myCharacter,
                              )
                                  .then((_) {
                                progress?.dismiss();
                                Navigator.pop(context, true);
                              });
                            } else {
                              showToast('선택하신 캐릭터의 레벨이\n레이드 입장 레벨보다 낮습니다.');
                            }
                          } else {
                            showToast('현재 시간보다 이전 시간으로\n모집 글을 등록할 수 없습니다.');
                          }
                        } else {
                          showToast('레이드 또는 출발 시간을 설정하지 않았습니다.');
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        height: 70.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.sp),
                          color: Colors.deepOrange[400],
                        ),
                        child: Text(
                          '등록하기',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomDrawer(context),
        ],
      ),
    );
  }
}
