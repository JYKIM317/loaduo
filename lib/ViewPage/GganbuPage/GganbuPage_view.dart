import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loaduo/ShowToastMsg.dart';
import 'FindGGanbu/FindGganbu_view.dart';
import 'FindStatic/FindStatic_view.dart';
import 'FindGuild/FindGuild_view.dart';
import 'FindRaidForToday/FindRaidForToday_view.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'FindGGanbu/FindGganbu_provider.dart';
import 'FindGuild/FindGuild_provider.dart';
import 'FindRaidForToday/FindRaidForToday_provider.dart';
import 'FindStatic/FindStatic_provider.dart';
import 'package:loaduo/ViewPage/MyPage/MyPage_viewmodel.dart';
import 'package:loaduo/ViewPage/GganbuPage/LoaTalk/MatchMaking/MatchMaking_view.dart';
import 'package:loaduo/ViewPage/GganbuPage/LoaTalk/MatchMaking/MatchMaking_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math' as math;

class GganbuPage extends ConsumerWidget {
  const GganbuPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String? userUID = FirebaseAuth.instance.currentUser!.uid;
    final progress = ProgressHUD.of(context);
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.fromLTRB(16.w, 44.h, 16.w, 34.h),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '제가 찾는 것은요',
            style: TextStyle(
              color: const Color.fromARGB(255, 21, 24, 29),
              fontSize: 24.sp,
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  ref.read(gganbuServerFilter.notifier).update(null);
                  ref.read(gganbuTypeFilter.notifier).clear();
                  ref.read(gganbuWeekDaySFilter.notifier).update(null);
                  ref.read(gganbuWeekDayEFilter.notifier).update(null);
                  ref.read(gganbuWeekEndSFilter.notifier).update(null);
                  ref.read(gganbuWeekEndEFilter.notifier).update(null);
                  //깐부
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProgressHUD(child: FindGganbu()),
                    ),
                  );
                },
                child: Container(
                  width: 160.w,
                  height: 140.h,
                  padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.sp),
                    color: const Color.fromARGB(255, 21, 24, 29),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '깐부',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.sp,
                        ),
                      ),
                      Text(
                        '레이드/내실\n/일일 숙제',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 18.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              InkWell(
                onTap: () {
                  ref.read(staticRaidFilter.notifier).update(null);
                  //고정공대
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProgressHUD(child: FindStatic()),
                    ),
                  );
                },
                child: Container(
                  width: 160.w,
                  height: 140.h,
                  padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.sp),
                    color: const Color.fromARGB(255, 21, 24, 29),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '고정공대',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.sp,
                        ),
                      ),
                      Text(
                        '레이드 고정 파티\n구인/구직',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 18.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  ref.read(guildServerFilter.notifier).update(null);
                  ref.read(guildTypeFilter.notifier).update(null);
                  ref.read(guildLevelFilter.notifier).update(null);
                  //길드
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProgressHUD(child: FindGuild()),
                    ),
                  );
                },
                child: Container(
                  width: 160.w,
                  height: 140.h,
                  padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.sp),
                    color: const Color.fromARGB(255, 21, 24, 29),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '길드',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.sp,
                        ),
                      ),
                      Text(
                        '길드 찾기\n/길드원 모집',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 18.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              InkWell(
                onTap: () {
                  ref.read(raidForTodayRaidFilter.notifier).update(null);
                  ref.read(raidForTodaySkillFilter.notifier).update(null);
                  ref.read(raidForTodaySFilter.notifier).update(null);
                  ref.read(raidForTodayEFilter.notifier).update(null);
                  //오늘 레이드
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProgressHUD(child: FindRaidForToday()),
                    ),
                  );
                },
                child: Container(
                  width: 160.w,
                  height: 140.h,
                  padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.sp),
                    color: const Color.fromARGB(255, 21, 24, 29),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '오늘 레이드',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.sp,
                        ),
                      ),
                      Text(
                        '레이드\n구인/구직',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 18.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 40.h),
          Text(
            '이런 기능도 있어요',
            style: TextStyle(
              color: const Color.fromARGB(255, 21, 24, 29),
              fontSize: 24.sp,
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () async {
                  progress?.show();
                  await MyPageViewModel()
                      .getUserInfo(userUID)
                      .then((myInfo) async {
                    if (myInfo['representCharacter'] != null) {
                      DateTime now = DateTime.now();
                      String credentialCharacter =
                          myInfo['credentialCharacter'] ?? '';
                      bool credential =
                          credentialCharacter == myInfo['representCharacter'];
                      Map<String, dynamic> myData = {
                        'uid': userUID,
                        'credential': credential,
                        'name': myInfo['representCharacter'],
                        'server': myInfo['representServer'],
                        'registeredTime': now,
                      };
                      //AnonymousChatting 초기화
                      await MatchMakingModel()
                          .initializeAnonymousChatting(uid: userUID);
                      //MatchMaking Standby 등록 후
                      await MatchMakingModel()
                          .registerStandByData(uid: userUID, data: myData);
                      //MatchMaking 요청 api 호출
                      try {
                        http.post(
                          Uri.parse(
                              'https://asia-northeast3-loaduo.cloudfunctions.net/createAnonymousChat'),
                          headers: <String, String>{
                            'Content-Type': 'application/json; charset=UTF-8',
                          },
                          body: jsonEncode({'time': DateTime.now().toString()}),
                        );
                      } catch (e) {
                        debugPrint(e.toString());
                      }

                      Future.microtask(() {
                        //매칭 중 페이지로 이동
                        progress?.dismiss();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MatchMakingPage(),
                          ),
                        );
                      });
                    } else {
                      progress?.dismiss();
                      showToast('원정대를 등록하지 않으셨습니다\n[내 정보] - [내 원정대 등록하기]');
                    }
                  });
                },
                child: Container(
                  width: 160.w,
                  height: 140.h,
                  padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.sp),
                    color: const Color.fromARGB(255, 21, 24, 29),
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Transform.translate(
                          offset: Offset(15.w, -10.h),
                          child: Transform.rotate(
                            angle: math.pi / 6.4,
                            child: Text(
                              'Beta',
                              style: TextStyle(
                                color: Colors.grey.withOpacity(0.6),
                                fontSize: 36.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '로아톡',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.sp,
                            ),
                          ),
                          Text(
                            '랜덤채팅',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 18.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Container(
                width: 160.w,
                height: 140.h,
                padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.sp),
                  color: Colors.transparent,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
