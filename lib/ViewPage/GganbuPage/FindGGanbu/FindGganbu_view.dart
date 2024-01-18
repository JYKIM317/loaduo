import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:bottom_drawer/bottom_drawer.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loaduo/ViewPage/MyPage/MyPage_viewmodel.dart';
import 'package:loaduo/ShowToastMsg.dart';
import 'package:loaduo/ViewPage/GganbuPage/FindGGanbu/CreateGganbuPost/CreateGganbuPost_view.dart';
import 'package:loaduo/ViewPage/GganbuPage/FindGGanbu/FindGganbu_provider.dart';
import 'FindGganbu_widget.dart';
import 'package:loaduo/lostark_info.dart';
import 'FindGganbu_viewmodel.dart';
import 'GganbuPostView/GganbuPostView_view.dart';

class FindGganbu extends ConsumerStatefulWidget {
  const FindGganbu({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FindGganbuState();
}

class _FindGganbuState extends ConsumerState<FindGganbu> {
  BottomDrawerController _bottomDrawerController = BottomDrawerController();

  Widget bottomDrawer(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: BottomDrawer(
        controller: _bottomDrawerController,
        header: const SizedBox(height: 0),
        cornerRadius: 16.sp,
        color: Colors.grey[100]!,
        followTheBody: false,
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            blurRadius: 1,
          )
        ],
        body: [
          ServerDrawer(bottomController: _bottomDrawerController),
          TypeDrawer(bottomController: _bottomDrawerController),
          WeekdayDrawer(bottomController: _bottomDrawerController),
          WeekendDrawer(bottomController: _bottomDrawerController),
        ][ref.watch(gganbuFilterIndex)], //widget view by filterIndex
        headerHeight: 0,
        drawerHeight: 472.h,
      ),
    );
  }

  int postCount = 30;
  late Future gganbuLoadData;
  var serverFilter;
  var typeFilter;
  var weekdaySFilter;
  var weekdayEFilter;
  var weekendSFilter;
  var weekendEFilter;

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

      gganbuLoadData = FindGganbuViewModel().getGganbuPostList(
        count: postCount,
        serverFilter: serverFilter,
        typeFilter: typeFilter,
        weekdayS: weekdaySFilter,
        weekdayE: weekdayEFilter,
        weekendS: weekendSFilter,
        weekendE: weekendEFilter,
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
    gganbuLoadData = FindGganbuViewModel().getGganbuPostList(
      count: postCount,
      serverFilter: serverFilter,
      typeFilter: typeFilter,
      weekdayS: weekdaySFilter,
      weekdayE: weekdayEFilter,
      weekendS: weekendSFilter,
      weekendE: weekendEFilter,
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
    serverFilter = ref.watch(gganbuServerFilter);
    typeFilter = ref.watch(gganbuTypeFilter);
    weekdaySFilter = ref.watch(gganbuWeekDaySFilter);
    weekdayEFilter = ref.watch(gganbuWeekDayEFilter);
    weekendSFilter = ref.watch(gganbuWeekEndSFilter);
    weekendEFilter = ref.watch(gganbuWeekEndEFilter);
    ref.listen(gganbuServerFilter, (previousState, newState) {
      serverFilter = newState;
      lastDoc = null;
      docList = null;
      gganbuLoadData = FindGganbuViewModel().getGganbuPostList(
        count: postCount,
        serverFilter: serverFilter,
        typeFilter: typeFilter,
        weekdayS: weekdaySFilter,
        weekdayE: weekdayEFilter,
        weekendS: weekendSFilter,
        weekendE: weekendEFilter,
        lastDoc: lastDoc,
      );
    });
    ref.listen(gganbuTypeFilter, (previousState, newState) {
      typeFilter = newState;
      lastDoc = null;
      docList = null;
      gganbuLoadData = FindGganbuViewModel().getGganbuPostList(
        count: postCount,
        serverFilter: serverFilter,
        typeFilter: typeFilter,
        weekdayS: weekdaySFilter,
        weekdayE: weekdayEFilter,
        weekendS: weekendSFilter,
        weekendE: weekendEFilter,
        lastDoc: lastDoc,
      );
    });
    ref.listen(gganbuWeekDaySFilter, (previousState, newState) {
      weekdaySFilter = newState;
      lastDoc = null;
      docList = null;
      gganbuLoadData = FindGganbuViewModel().getGganbuPostList(
        count: postCount,
        serverFilter: serverFilter,
        typeFilter: typeFilter,
        weekdayS: weekdaySFilter,
        weekdayE: weekdayEFilter,
        weekendS: weekendSFilter,
        weekendE: weekendEFilter,
        lastDoc: lastDoc,
      );
    });
    ref.listen(gganbuWeekDayEFilter, (previousState, newState) {
      weekdayEFilter = newState;
      lastDoc = null;
      docList = null;
      gganbuLoadData = FindGganbuViewModel().getGganbuPostList(
        count: postCount,
        serverFilter: serverFilter,
        typeFilter: typeFilter,
        weekdayS: weekdaySFilter,
        weekdayE: weekdayEFilter,
        weekendS: weekendSFilter,
        weekendE: weekendEFilter,
        lastDoc: lastDoc,
      );
    });
    ref.listen(gganbuWeekEndSFilter, (previousState, newState) {
      weekendSFilter = newState;
      lastDoc = null;
      docList = null;
      gganbuLoadData = FindGganbuViewModel().getGganbuPostList(
        count: postCount,
        serverFilter: serverFilter,
        typeFilter: typeFilter,
        weekdayS: weekdaySFilter,
        weekdayE: weekdayEFilter,
        weekendS: weekendSFilter,
        weekendE: weekendEFilter,
        lastDoc: lastDoc,
      );
    });
    ref.listen(gganbuWeekEndEFilter, (previousState, newState) {
      weekendEFilter = newState;
      lastDoc = null;
      docList = null;
      gganbuLoadData = FindGganbuViewModel().getGganbuPostList(
        count: postCount,
        serverFilter: serverFilter,
        typeFilter: typeFilter,
        weekdayS: weekdaySFilter,
        weekdayE: weekdayEFilter,
        weekendS: weekendSFilter,
        weekendE: weekendEFilter,
        lastDoc: lastDoc,
      );
    });

    return GestureDetector(
      onTap: () {
        _bottomDrawerController.close();
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            String? userUID = FirebaseAuth.instance.currentUser!.uid;
            progress?.show();
            await MyPageViewModel().getUserInfo(userUID).then((value) {
              Future.microtask(() async {
                progress?.dismiss();
                if (value['representCharacter'] != null) {
                  value.addAll({'uid': userUID});
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) =>
                          ProgressHUD(child: CreateGganbuPost(myInfo: value))),
                    ),
                  ).then((value) {
                    bool create = value ?? false;
                    if (create) {
                      setState(() {
                        lastDoc = null;
                        docList = null;
                        gganbuLoadData =
                            FindGganbuViewModel().getGganbuPostList(
                          count: postCount,
                          serverFilter: serverFilter,
                          typeFilter: typeFilter,
                          weekdayS: weekdaySFilter,
                          weekdayE: weekdayEFilter,
                          weekendS: weekendSFilter,
                          weekendE: weekendEFilter,
                          lastDoc: lastDoc,
                        );
                      });
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
                      '깐부',
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
                            ref.read(gganbuFilterIndex.notifier).update(0);
                            _bottomDrawerController.open();
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 8.h),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.sp),
                              color: serverFilter == null
                                  ? Colors.grey
                                  : Colors.deepOrange[400],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  serverFilter ?? '서버 전체',
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
                            ref.read(gganbuFilterIndex.notifier).update(1);
                            _bottomDrawerController.open();
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 8.h),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.sp),
                              color: typeFilter == null
                                  ? Colors.grey
                                  : Colors.deepOrange[400],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  (typeFilter ?? '깐부 종류 전체')
                                      .toString()
                                      .replaceAll(RegExp(r'\[|\]'), ''),
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
                            ref.read(gganbuFilterIndex.notifier).update(2);
                            _bottomDrawerController.open();
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 8.h),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.sp),
                              color: (weekdaySFilter == null &&
                                      weekdayEFilter == null)
                                  ? Colors.grey
                                  : Colors.deepOrange[400],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  (weekdaySFilter == null &&
                                          weekdayEFilter == null)
                                      ? '평일 시간대 전체'
                                      : '평일 ${(weekdaySFilter == null ? '"' : '${weekdaySFilter.toString().padLeft(2, '0')}:00')} ~ ${(weekdayEFilter == null ? '"' : '${weekdayEFilter.toString().padLeft(2, '0')}:59')}',
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
                            ref.read(gganbuFilterIndex.notifier).update(3);
                            _bottomDrawerController.open();
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 8.h),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.sp),
                              color: (ref.watch(gganbuWeekEndSFilter) == null &&
                                      ref.watch(gganbuWeekEndEFilter) == null)
                                  ? Colors.grey
                                  : Colors.deepOrange[400],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  (weekendSFilter == null &&
                                          weekendEFilter == null)
                                      ? '주말 시간대 전체'
                                      : '주말 ${(weekendSFilter == null ? '"' : '${weekendSFilter.toString().padLeft(2, '0')}:00')} ~ ${(weekendEFilter == null ? '"' : '${weekendEFilter.toString().padLeft(2, '0')}:59')}',
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
                          future: gganbuLoadData,
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
                                return InkWell(
                                  onTap: () {
                                    //자세히 보기
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProgressHUD(
                                          child: GganbuPostView(
                                            post: post,
                                          ),
                                        ),
                                      ),
                                    );
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
                                            offset: Offset(180.w, 20.h),
                                            child: Transform.scale(
                                              scale: 3,
                                              child: Image.network(
                                                lostarkInfo()
                                                    .networkImage['깐부']!,
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
                                              child: Text(
                                                post['detail'],
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 24.sp,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
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
                                                            '${post['representServer']} ',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18.sp,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                if (post['concern'].length >= 1)
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
                                                              '${post['concern'][0]} ',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18.sp,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                if (post['concern'].length >= 2)
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
                                                              '${post['concern'][1]} ',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18.sp,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                if (post['concern'].length >= 3)
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
                                                              '${post['concern'][2]} ',
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
                                                            '평일 ${post['weekdayPlaytime']}시 ',
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
                                                            '주말 ${post['weekendPlaytime']}시 ',
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
