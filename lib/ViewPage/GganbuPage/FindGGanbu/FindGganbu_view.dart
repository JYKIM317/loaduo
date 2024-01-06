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

  @override
  Widget build(BuildContext context) {
    final progress = ProgressHUD.of(context);
    final serverFilter = ref.watch(gganbuServerFilter);
    final typeFilter = ref.watch(gganbuTypeFilter);
    final weekdaySFilter = ref.watch(gganbuWeekDaySFilter);
    final weekdayEFilter = ref.watch(gganbuWeekDayEFilter);
    final weekendSFilter = ref.watch(gganbuWeekEndSFilter);
    final weekendEFilter = ref.watch(gganbuWeekEndEFilter);
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
              Future.microtask(() {
                progress?.dismiss();
                if (value['representCharacter'] != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => CreateGganbuPost(myInfo: value)),
                    ),
                  );
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Container(
                              width: double.infinity,
                              height: 210.h,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.sp),
                                color: const Color.fromARGB(255, 21, 24, 29),
                              ),
                              padding:
                                  EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 20.h),
                              child: Stack(
                                children: [
                                  Opacity(
                                    opacity: 0.1,
                                    child: Transform.translate(
                                      offset: Offset(180.w, 20.h),
                                      child: Transform.scale(
                                        scale: 3,
                                        child: Image.network(
                                          lostarkInfo().networkImage['깐부']!,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Container(
                                                color: const Color.fromARGB(
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
                                          '저랑 깐부하실 분! 본캐 1630에 1600 2개 1580 3개 있어요! ',
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
                                                  text: '니나브 ',
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
                                                  text: '레이드 ',
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
                                                  text: '내실 ',
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
                                                  text: '일일 숙제 ',
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
                                                  text: '평일 20시 ',
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
                                                  text: '주말 16시 ',
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
                          ),
                          SizedBox(height: 10.h),
                          Container(
                            width: double.infinity,
                            height: 210.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.sp),
                              color: const Color.fromARGB(255, 21, 24, 29)
                                  .withOpacity(0.8),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Container(
                            width: double.infinity,
                            height: 210.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.sp),
                              color: const Color.fromARGB(255, 21, 24, 29)
                                  .withOpacity(0.8),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Container(
                            width: double.infinity,
                            height: 210.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.sp),
                              color: const Color.fromARGB(255, 21, 24, 29)
                                  .withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
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
