import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:bottom_drawer/bottom_drawer.dart';
import 'package:loaduo/ViewPage/GganbuPage/FindRaidForToday/FindRaidForToday_provider.dart';
import 'FindRaidForToday_widget.dart';

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

  @override
  Widget build(BuildContext context) {
    final raidFilter = ref.watch(raidForTodayRaidFilter);
    final skillFilter = ref.watch(raidForTodaySkillFilter);
    final timeSFilter = ref.watch(raidForTodaySFilter);
    final timeEFilter = ref.watch(raidForTodayEFilter);
    return GestureDetector(
      onTap: () => _bottomDrawerController.close(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 210.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.sp),
                              color: const Color.fromARGB(255, 21, 24, 29),
                            ),
                            padding:
                                EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 20.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                          ),
                          SizedBox(height: 10.h),
                          Container(
                            width: double.infinity,
                            height: 210.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.sp),
                              color: const Color.fromARGB(255, 21, 24, 29),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Container(
                            width: double.infinity,
                            height: 210.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.sp),
                              color: const Color.fromARGB(255, 21, 24, 29),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Container(
                            width: double.infinity,
                            height: 210.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.sp),
                              color: const Color.fromARGB(255, 21, 24, 29),
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
