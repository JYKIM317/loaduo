import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:bottom_drawer/bottom_drawer.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loaduo/ViewPage/GganbuPage/MyExpedition_view.dart';
import 'package:loaduo/ViewPage/MyPage/MyPage_viewmodel.dart';
import 'package:loaduo/ShowToastMsg.dart';
import 'package:loaduo/ViewPage/GganbuPage/FindRaidForToday/CreateRaidForTodayPost/CreateRaidForTodayPost_view.dart';
import 'package:loaduo/ViewPage/GganbuPage/FindRaidForToday/FindRaidForToday_provider.dart';
import 'FindRaidForToday_widget.dart';
import 'package:loaduo/lostark_info.dart';
import 'FindRaidForToday_viewmodel.dart';
import 'RaidForTodayPostView/RaidForTodayPostView_view.dart';
import 'RaidForTodayPostView/RaidForTodayPostView_viewmodel.dart';

class FindRaidForToday extends ConsumerStatefulWidget {
  const FindRaidForToday({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FindRaidForTodayState();
}

class _FindRaidForTodayState extends ConsumerState<FindRaidForToday> {
  BottomDrawerController _bottomDrawerController = BottomDrawerController();

  Widget bottomDrawer(BuildContext context) {
    return GestureDetector(
      onTap: () {},
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
          RaidDrawer(bottomController: _bottomDrawerController),
          SkillDrawer(bottomController: _bottomDrawerController),
          TimeDrawer(bottomController: _bottomDrawerController),
        ][ref.watch(raidForTodayFilterIndex)], //widget view by filterIndex
        headerHeight: 0,
        drawerHeight: 472.h,
      ),
    );
  }

  int postCount = 30;
  late Future raidForTodayLoadData;
  var raidFilter;
  var skillFilter;
  var timeSFilter;
  var timeEFilter;

  DocumentSnapshot? lastDoc;
  List<Map<String, dynamic>>? docList;
  bool isLoad = false;
  ScrollController scrollController = ScrollController();
  double? lastScrollOffset;
  onScroll() async {
    bool reachMaxExtent =
        scrollController.offset >= scrollController.position.maxScrollExtent;
    bool outOfRange = !scrollController.position.outOfRange &&
        scrollController.position.pixels != 0;
    bool existInitalData = lastDoc != null;

    if (reachMaxExtent && outOfRange && existInitalData && isLoad == false) {
      isLoad = true;
      lastScrollOffset = scrollController.position.maxScrollExtent;

      raidForTodayLoadData =
          FindRaidForTodayViewModel().getRaidForTodayPostList(
        count: postCount,
        raid: raidFilter,
        skill: skillFilter,
        timeS: timeSFilter,
        timeE: timeEFilter,
        lastDoc: lastDoc,
        initialList: docList,
      );
      Future.delayed(const Duration(milliseconds: 500)).then((_) {
        setState(() {});
      });

      isLoad = false;
    }
  }

  @override
  void initState() {
    raidForTodayLoadData = FindRaidForTodayViewModel().getRaidForTodayPostList(
      count: postCount,
      raid: raidFilter,
      skill: skillFilter,
      timeS: timeSFilter,
      timeE: timeEFilter,
      lastDoc: lastDoc,
    );
    scrollController.addListener(() {
      onScroll();
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progress = ProgressHUD.of(context);
    raidFilter = ref.watch(raidForTodayRaidFilter);
    skillFilter = ref.watch(raidForTodaySkillFilter);
    timeSFilter = ref.watch(raidForTodaySFilter);
    timeEFilter = ref.watch(raidForTodayEFilter);
    ref.listen(raidForTodayRaidFilter, (previousState, newState) {
      raidFilter = newState;
      lastDoc = null;
      docList = null;
      raidForTodayLoadData =
          FindRaidForTodayViewModel().getRaidForTodayPostList(
        count: postCount,
        raid: raidFilter,
        skill: skillFilter,
        timeS: timeSFilter,
        timeE: timeEFilter,
        lastDoc: lastDoc,
      );
    });
    ref.listen(raidForTodaySkillFilter, (previousState, newState) {
      skillFilter = newState;
      lastDoc = null;
      docList = null;
      raidForTodayLoadData =
          FindRaidForTodayViewModel().getRaidForTodayPostList(
        count: postCount,
        raid: raidFilter,
        skill: skillFilter,
        timeS: timeSFilter,
        timeE: timeEFilter,
        lastDoc: lastDoc,
      );
    });
    ref.listen(raidForTodaySFilter, (previousState, newState) {
      timeSFilter = newState;
      lastDoc = null;
      docList = null;
      raidForTodayLoadData =
          FindRaidForTodayViewModel().getRaidForTodayPostList(
        count: postCount,
        raid: raidFilter,
        skill: skillFilter,
        timeS: timeSFilter,
        timeE: timeEFilter,
        lastDoc: lastDoc,
      );
    });
    ref.listen(raidForTodayEFilter, (previousState, newState) {
      timeEFilter = newState;
      lastDoc = null;
      docList = null;
      raidForTodayLoadData =
          FindRaidForTodayViewModel().getRaidForTodayPostList(
        count: postCount,
        raid: raidFilter,
        skill: skillFilter,
        timeS: timeSFilter,
        timeE: timeEFilter,
        lastDoc: lastDoc,
      );
    });

    return GestureDetector(
      onTap: () => _bottomDrawerController.close(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            String? userUID = FirebaseAuth.instance.currentUser!.uid;
            progress?.show();
            await MyPageViewModel().getUserInfo(userUID).then((value) {
              Future.microtask(() async {
                progress?.dismiss();
                if (value['representCharacter'] != null) {
                  await MyPageViewModel()
                      .getUserExpedition(userUID)
                      .then((expedition) async {
                    if (expedition.isNotEmpty) {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MyExpedition(expedition: expedition),
                        ),
                      ).then((character) {
                        if (character != null) {
                          bool credential = false;
                          if (value['representCharacter'] ==
                              value['credentialCharacter']) {
                            credential = true;
                          }
                          character.addAll({
                            'uid': userUID,
                            'credential': credential,
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProgressHUD(
                                child: CreateRaidForTodayPost(
                                    myCharacter: character),
                              ),
                            ),
                          );
                        }
                      });
                    } else {
                      showToast('원정대 정보를 확인 할 수 없습니다.\n[내 정보] - [내 원정대 등록하기]');
                    }
                  });
                } else {
                  showToast('내 원정대를 등록해주세요\n[내 정보] - [내 원정대 등록하기]');
                }
              });
            });
          },
          backgroundColor: Colors.deepOrange[400],
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 36.sp,
          ),
        ),
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 16.w, top: 84.h),
                    child: Text(
                      '오늘 레이드',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 21, 24, 29),
                        fontSize: 36.sp,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    height: 70.h,
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                      ),
                      physics: const ClampingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: [
                        InkWell(
                          onTap: () {
                            _bottomDrawerController.close();
                            ref
                                .read(raidForTodayFilterIndex.notifier)
                                .update(0);
                            _bottomDrawerController.open();
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 8.h),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.sp),
                              color: raidFilter == null
                                  ? Colors.grey
                                  : Colors.deepOrange[400],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  raidFilter ?? '레이드 전체',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.sp,
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
                        SizedBox(width: 10.w),
                        InkWell(
                          onTap: () {
                            _bottomDrawerController.close();
                            ref
                                .read(raidForTodayFilterIndex.notifier)
                                .update(1);
                            _bottomDrawerController.open();
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 8.h),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.sp),
                              color: skillFilter == null
                                  ? Colors.grey
                                  : Colors.deepOrange[400],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  skillFilter ?? '숙련도 전체',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.sp,
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
                        SizedBox(width: 10.w),
                        InkWell(
                          onTap: () {
                            _bottomDrawerController.close();
                            ref
                                .read(raidForTodayFilterIndex.notifier)
                                .update(2);
                            _bottomDrawerController.open();
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 8.h),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.sp),
                              color:
                                  (timeSFilter == null && timeEFilter == null)
                                      ? Colors.grey
                                      : Colors.deepOrange[400],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  (timeSFilter == null && timeEFilter == null)
                                      ? '시간대 전체'
                                      : '${(timeSFilter == null ? '"' : '${timeSFilter.hour.toString().padLeft(2, '0')}:${timeSFilter.minute.toString().padLeft(2, '0')}')} ~ ${(timeEFilter == null ? '"' : '${timeEFilter.hour.toString().padLeft(2, '0')}:${timeEFilter.minute.toString().padLeft(2, '0')}')}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.sp,
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
                  Divider(
                    color: Colors.grey[300],
                    thickness: 2.h,
                    height: 40.h,
                  ),
                  SizedBox(height: 10.h),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 10.h),
                      physics: const ClampingScrollPhysics(),
                      controller: scrollController,
                      child: FutureBuilder(
                          future: raidForTodayLoadData,
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.waiting &&
                                docList == null) {
                              return SizedBox(
                                height: 246.h,
                                child: Center(
                                    child: CircularProgressIndicator(
                                  color: Colors.deepOrange[400],
                                )),
                              );
                            }
                            List<Map<String, dynamic>> postList =
                                snapshot.data['postList'] ?? [];
                            if (snapshot.data['lastDoc'] != null) {
                              lastDoc = snapshot.data['lastDoc'];
                              docList = postList;
                            }
                            return ListView.separated(
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              itemCount: postList.length,
                              itemBuilder: (BuildContext ctx, int idx) {
                                Map<String, dynamic> post = postList[idx];
                                DateTime startTime = post['startTime'].toDate();
                                return InkWell(
                                  onTap: () async {
                                    //자세히 보기
                                    progress?.show();
                                    await RaidForTodayPostViewModel()
                                        .getPostData(address: post['address'])
                                        .then((newestPost) async {
                                      progress?.dismiss();
                                      if (newestPost.isNotEmpty) {
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ProgressHUD(
                                              child: RaidForTodayPostView(
                                                post: newestPost,
                                              ),
                                            ),
                                          ),
                                        ).then((value) {
                                          bool leave = value ?? false;
                                          if (leave) {
                                            setState(() {
                                              lastDoc = null;
                                              docList = null;
                                              raidForTodayLoadData =
                                                  FindRaidForTodayViewModel()
                                                      .getRaidForTodayPostList(
                                                count: postCount,
                                                raid: raidFilter,
                                                skill: skillFilter,
                                                timeS: timeSFilter,
                                                timeE: timeEFilter,
                                                lastDoc: lastDoc,
                                              );
                                            });
                                          }
                                        });
                                      } else {
                                        showToast('존재하지 않는 방입니다.');
                                      }
                                    });
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 210.h,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.sp),
                                      color:
                                          const Color.fromARGB(255, 21, 24, 29),
                                    ),
                                    padding: EdgeInsets.fromLTRB(
                                        16.w, 20.h, 16.w, 20.h),
                                    child: Stack(
                                      children: [
                                        Opacity(
                                          opacity: 0.2,
                                          child: Transform.translate(
                                            offset: Offset(80.w, 20.h),
                                            child: Transform.scale(
                                              scale: 3,
                                              child: Image.network(
                                                lostarkInfo().networkImage[
                                                    post['raidName']]!,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Container(
                                                      color:
                                                          const Color.fromARGB(
                                                              255, 21, 24, 29));
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    post['detail'],
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 24.sp,
                                                    ),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    '[${post['raidPlayer']}/${post['raidMaxPlayer']}]',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 24.sp,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text.rich(
                                                  TextSpan(
                                                    text: '#',
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 18.sp,
                                                    ),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text:
                                                            '${post['raid']} ',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18.sp,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text.rich(
                                                  TextSpan(
                                                    text: '#',
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 18.sp,
                                                    ),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text:
                                                            '${post['skill']} ',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18.sp,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Text.rich(
                                                  TextSpan(
                                                    text: '#',
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 18.sp,
                                                    ),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text:
                                                            '${startTime.hour}시 ${startTime.minute}분 ',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18.sp,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (ctx, idx) {
                                return SizedBox(height: 10.h);
                              },
                            );
                          }),
                    ),
                  ),
                ],
              ),
            ),
            bottomDrawer(context),
          ],
        ),
      ),
    );
  }
}
