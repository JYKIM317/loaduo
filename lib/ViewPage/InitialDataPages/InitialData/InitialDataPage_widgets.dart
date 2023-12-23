import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:loaduo/ViewPage/InitialDataPages/InitialData/InitialDataPage_provider.dart';

class Purpose extends ConsumerWidget {
  const Purpose({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bossState = ref.watch(bossraid);
    final adventureState = ref.watch(adventure);
    final homeworkState = ref.watch(homework);

    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '주요 목표는 무엇인가요?',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24.sp,
            ),
          ),
          SizedBox(height: 20.h),
          InkWell(
            onTap: () {
              bossState
                  ? ref.read(bossraid.notifier).selectFalse()
                  : ref.read(bossraid.notifier).selectTrue();
            },
            child: Container(
              height: 100.h,
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 10.w, right: 10.w),
              decoration: BoxDecoration(
                color: bossState ? Colors.white : Colors.deepOrange[200],
                borderRadius: BorderRadius.circular(16.sp),
                border: bossState
                    ? Border.all(
                        color: Colors.deepOrange[400]!,
                        width: 2,
                      )
                    : null,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        '레이드 같이 빼기',
                        style: TextStyle(
                          color:
                              bossState ? Colors.deepOrange[400] : Colors.white,
                          fontSize: 18.sp,
                        ),
                      ),
                    ),
                  ),
                  Icon(
                    bossState ? Icons.check : null,
                    size: 28.sp,
                    color: Colors.deepOrange[400],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 6.h),
          InkWell(
            onTap: () {
              adventureState
                  ? ref.read(adventure.notifier).selectFalse()
                  : ref.read(adventure.notifier).selectTrue();
            },
            child: Container(
              height: 100.h,
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 10.w, right: 10.w),
              decoration: BoxDecoration(
                color: adventureState ? Colors.white : Colors.deepOrange[100],
                borderRadius: BorderRadius.circular(16.sp),
                border: adventureState
                    ? Border.all(
                        color: Colors.deepOrange[400]!,
                        width: 2,
                      )
                    : null,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        '내실 같이 빼기',
                        style: TextStyle(
                          color: adventureState
                              ? Colors.deepOrange[400]
                              : Colors.white,
                          fontSize: 18.sp,
                        ),
                      ),
                    ),
                  ),
                  Icon(
                    adventureState ? Icons.check : null,
                    size: 28.sp,
                    color: Colors.deepOrange[400],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 6.h),
          InkWell(
            onTap: () {
              homeworkState
                  ? ref.read(homework.notifier).selectFalse()
                  : ref.read(homework.notifier).selectTrue();
            },
            child: Container(
              height: 100.h,
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 10.w, right: 10.w),
              decoration: BoxDecoration(
                color: homeworkState ? Colors.white : Colors.deepOrange[200],
                borderRadius: BorderRadius.circular(16.sp),
                border: homeworkState
                    ? Border.all(
                        color: Colors.deepOrange[400]!,
                        width: 2,
                      )
                    : null,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        '일일숙제 같이 빼기',
                        style: TextStyle(
                          color: homeworkState
                              ? Colors.deepOrange[400]
                              : Colors.white,
                          fontSize: 18.sp,
                        ),
                      ),
                    ),
                  ),
                  Icon(
                    homeworkState ? Icons.check : null,
                    size: 28.sp,
                    color: Colors.deepOrange[400],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PlayStyle extends ConsumerWidget {
  const PlayStyle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mood = ref.watch(yourmood);
    final distribute = ref.watch(yourdistribute);
    final skill = ref.watch(yourskill);
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '나의 레이드는 어떤가요?',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24.sp,
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  ref.read(yourmood.notifier).select0();
                },
                child: Container(
                  height: 80.h,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 10.w, right: 10.w),
                  decoration: BoxDecoration(
                    color: mood == 0 ? Colors.white : Colors.deepOrange[200],
                    borderRadius: BorderRadius.circular(16.sp),
                    border: mood == 0
                        ? Border.all(
                            color: Colors.deepOrange[400]!,
                            width: 2,
                          )
                        : null,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '예민하지 않아요',
                        style: TextStyle(
                          color:
                              mood == 0 ? Colors.deepOrange[400] : Colors.white,
                          fontSize: 18.sp,
                        ),
                      ),
                      Icon(
                        mood == 0 ? Icons.check : null,
                        size: 28.sp,
                        color: Colors.deepOrange[400],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              InkWell(
                onTap: () {
                  ref.read(yourmood.notifier).select1();
                },
                child: Container(
                  height: 80.h,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 10.w, right: 10.w),
                  decoration: BoxDecoration(
                    color: mood == 1 ? Colors.white : Colors.deepOrange[200],
                    borderRadius: BorderRadius.circular(16.sp),
                    border: mood == 1
                        ? Border.all(
                            color: Colors.deepOrange[400]!,
                            width: 2,
                          )
                        : null,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '예민해요',
                        style: TextStyle(
                          color:
                              mood == 1 ? Colors.deepOrange[400] : Colors.white,
                          fontSize: 18.sp,
                        ),
                      ),
                      Icon(
                        mood == 1 ? Icons.check : null,
                        size: 28.sp,
                        color: Colors.deepOrange[400],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  ref.read(yourdistribute.notifier).select0();
                },
                child: Container(
                  height: 80.h,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 10.w, right: 10.w),
                  decoration: BoxDecoration(
                    color:
                        distribute == 0 ? Colors.white : Colors.deepOrange[100],
                    borderRadius: BorderRadius.circular(16.sp),
                    border: distribute == 0
                        ? Border.all(
                            color: Colors.deepOrange[400]!,
                            width: 2,
                          )
                        : null,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '천천히 빼요',
                        style: TextStyle(
                          color: distribute == 0
                              ? Colors.deepOrange[400]
                              : Colors.white,
                          fontSize: 18.sp,
                        ),
                      ),
                      Icon(
                        distribute == 0 ? Icons.check : null,
                        size: 28.sp,
                        color: Colors.deepOrange[400],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              InkWell(
                onTap: () {
                  ref.read(yourdistribute.notifier).select1();
                },
                child: Container(
                  height: 80.h,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 10.w, right: 10.w),
                  decoration: BoxDecoration(
                    color:
                        distribute == 1 ? Colors.white : Colors.deepOrange[100],
                    borderRadius: BorderRadius.circular(16.sp),
                    border: distribute == 1
                        ? Border.all(
                            color: Colors.deepOrange[400]!,
                            width: 2,
                          )
                        : null,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '몰아서 빼요',
                        style: TextStyle(
                          color: distribute == 1
                              ? Colors.deepOrange[400]
                              : Colors.white,
                          fontSize: 18.sp,
                        ),
                      ),
                      Icon(
                        distribute == 1 ? Icons.check : null,
                        size: 28.sp,
                        color: Colors.deepOrange[400],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          SizedBox(
            height: 80.h,
            child: ListView(
              physics: const ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: [
                InkWell(
                  onTap: () {
                    ref.read(yourskill.notifier).select0();
                  },
                  child: Container(
                    height: 80.h,
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(left: 10.w, right: 10.w),
                    decoration: BoxDecoration(
                      color: skill == 0 ? Colors.white : Colors.deepOrange[200],
                      borderRadius: BorderRadius.circular(16.sp),
                      border: skill == 0
                          ? Border.all(
                              color: Colors.deepOrange[400]!,
                              width: 2,
                            )
                          : null,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '숙련',
                          style: TextStyle(
                            color: skill == 0
                                ? Colors.deepOrange[400]
                                : Colors.white,
                            fontSize: 18.sp,
                          ),
                        ),
                        Icon(
                          skill == 0 ? Icons.check : null,
                          size: 28.sp,
                          color: Colors.deepOrange[400],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                InkWell(
                  onTap: () {
                    ref.read(yourskill.notifier).select1();
                  },
                  child: Container(
                    height: 80.h,
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(left: 10.w, right: 10.w),
                    decoration: BoxDecoration(
                      color: skill == 1 ? Colors.white : Colors.deepOrange[200],
                      borderRadius: BorderRadius.circular(16.sp),
                      border: skill == 1
                          ? Border.all(
                              color: Colors.deepOrange[400]!,
                              width: 2,
                            )
                          : null,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '반숙',
                          style: TextStyle(
                            color: skill == 1
                                ? Colors.deepOrange[400]
                                : Colors.white,
                            fontSize: 18.sp,
                          ),
                        ),
                        Icon(
                          skill == 1 ? Icons.check : null,
                          size: 28.sp,
                          color: Colors.deepOrange[400],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                InkWell(
                  onTap: () {
                    ref.read(yourskill.notifier).select2();
                  },
                  child: Container(
                    height: 80.h,
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(left: 10.w, right: 10.w),
                    decoration: BoxDecoration(
                      color: skill == 2 ? Colors.white : Colors.deepOrange[200],
                      borderRadius: BorderRadius.circular(16.sp),
                      border: skill == 2
                          ? Border.all(
                              color: Colors.deepOrange[400]!,
                              width: 2,
                            )
                          : null,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '클경',
                          style: TextStyle(
                            color: skill == 2
                                ? Colors.deepOrange[400]
                                : Colors.white,
                            fontSize: 18.sp,
                          ),
                        ),
                        Icon(
                          skill == 2 ? Icons.check : null,
                          size: 28.sp,
                          color: Colors.deepOrange[400],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                InkWell(
                  onTap: () {
                    ref.read(yourskill.notifier).select3();
                  },
                  child: Container(
                    height: 80.h,
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(left: 10.w, right: 10.w),
                    decoration: BoxDecoration(
                      color: skill == 3 ? Colors.white : Colors.deepOrange[200],
                      borderRadius: BorderRadius.circular(16.sp),
                      border: skill == 3
                          ? Border.all(
                              color: Colors.deepOrange[400]!,
                              width: 2,
                            )
                          : null,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '트라이',
                          style: TextStyle(
                            color: skill == 3
                                ? Colors.deepOrange[400]
                                : Colors.white,
                            fontSize: 18.sp,
                          ),
                        ),
                        Icon(
                          skill == 3 ? Icons.check : null,
                          size: 28.sp,
                          color: Colors.deepOrange[400],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PlayTime extends ConsumerStatefulWidget {
  const PlayTime({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PlayTimeState();
}

class _PlayTimeState extends ConsumerState<PlayTime> {
  OverlayEntry? overlayEntry;
  final LayerLink weekdaylayerLink = LayerLink();
  final LayerLink weekendlayerLink = LayerLink();
  final double _dropdownWidth = 80.w;
  final double _dropdownHeight = 55.h;

  final List<int> timeList = [
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23
  ];

  OverlayEntry weekdayOverlay() {
    return OverlayEntry(
      maintainState: true,
      builder: (context) => Positioned(
        width: _dropdownWidth,
        child: CompositedTransformFollower(
          link: weekdaylayerLink,
          offset: Offset(0, _dropdownHeight),
          child: Material(
            color: Colors.white,
            child: Container(
              height: 240.h,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5.sp),
              ),
              child: ListView.separated(
                physics: const ClampingScrollPhysics(),
                padding: EdgeInsets.symmetric(vertical: 6.h),
                itemCount: timeList.length,
                itemBuilder: (context, index) {
                  return IconButton(
                    onPressed: () async {
                      ref
                          .read(weekdayPlaytime.notifier)
                          .update(timeList[index]);
                      _removeOverlay();
                    },
                    icon: Text(
                      timeList[index].toString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.sp,
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.h),
                    child: Divider(
                      color: Colors.grey,
                      height: 4.h,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void weekdayDropdown() {
    if (overlayEntry == null) {
      overlayEntry = weekdayOverlay();
      Overlay.of(context).insert(overlayEntry!);
    }
  }

  OverlayEntry weekendOverlay() {
    return OverlayEntry(
      maintainState: true,
      builder: (context) => Positioned(
        width: _dropdownWidth,
        child: CompositedTransformFollower(
          link: weekendlayerLink,
          offset: Offset(0, _dropdownHeight),
          child: Material(
            color: Colors.white,
            child: Container(
              height: 210.h,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5.sp),
              ),
              child: ListView.separated(
                physics: const ClampingScrollPhysics(),
                padding: EdgeInsets.symmetric(vertical: 6.h),
                itemCount: timeList.length,
                itemBuilder: (context, index) {
                  return IconButton(
                    onPressed: () async {
                      ref
                          .read(weekendPlaytime.notifier)
                          .update(timeList[index]);
                      _removeOverlay();
                    },
                    icon: Text(
                      timeList[index].toString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.sp,
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.h),
                    child: Divider(
                      color: Colors.grey,
                      height: 4.h,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void weekendDropdown() {
    if (overlayEntry == null) {
      overlayEntry = weekendOverlay();
      Overlay.of(context).insert(overlayEntry!);
    }
  }

  void _removeOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  @override
  void dispose() {
    overlayEntry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final weekday = ref.watch(weekdayPlaytime);
    final weekend = ref.watch(weekendPlaytime);

    return GestureDetector(
      onTap: () {
        _removeOverlay();
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '주로 접속하는 \n시간대는 언제인가요?',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24.sp,
              ),
            ),
            SizedBox(height: 32.h),
            Row(
              children: [
                Text(
                  '평일',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24.sp,
                  ),
                ),
                SizedBox(width: 10.w),
                CompositedTransformTarget(
                  link: weekdaylayerLink,
                  child: InkWell(
                    onTap: () {
                      _removeOverlay();
                      weekdayDropdown();
                    },
                    child: Container(
                      width: 80.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: Colors.deepOrange[100],
                        borderRadius: BorderRadius.circular(12.w),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        weekday.toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.sp,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 6.w),
                Text(
                  '시',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24.sp,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Text(
                  '주말',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24.sp,
                  ),
                ),
                SizedBox(width: 10.w),
                CompositedTransformTarget(
                  link: weekendlayerLink,
                  child: InkWell(
                    onTap: () {
                      _removeOverlay();
                      weekendDropdown();
                    },
                    child: Container(
                      width: 80.w,
                      height: 50.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.deepOrange[100],
                        borderRadius: BorderRadius.circular(12.w),
                      ),
                      child: Text(
                        weekend.toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.sp,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 6.w),
                Text(
                  '시',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
