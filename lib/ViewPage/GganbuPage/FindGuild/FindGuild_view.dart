import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:bottom_drawer/bottom_drawer.dart';
import 'package:loaduo/ViewPage/GganbuPage/FindGuild/FindGuild_provider.dart';
import 'FindGuild_widget.dart';

class FindGuild extends ConsumerStatefulWidget {
  const FindGuild({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FindGuildState();
}

class _FindGuildState extends ConsumerState<FindGuild> {
  BottomDrawerController _bottomDrawerController = BottomDrawerController();

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
          ServerDrawer(bottomController: _bottomDrawerController),
          TypeDrawer(bottomController: _bottomDrawerController),
          LevelDrawer(bottomController: _bottomDrawerController),
        ][ref.watch(guildFilterIndex)], //widget view by filterIndex
        headerHeight: 0,
        drawerHeight: 472.h,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final serverFilter = ref.watch(guildServerFilter);
    final typeFilter = ref.watch(guildTypeFilter);
    final levelFilter = ref.watch(guildLevelFilter);
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
                      '길드',
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
                            ref.read(guildFilterIndex.notifier).update(0);
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
                            ref.read(guildFilterIndex.notifier).update(1);
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
                                  typeFilter ?? '길드 유형 전체',
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
                            ref.read(guildFilterIndex.notifier).update(2);
                            _bottomDrawerController.open();
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 8.h),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.sp),
                              color: levelFilter == null
                                  ? Colors.grey
                                  : Colors.deepOrange[400],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  levelFilter == null
                                      ? '레벨 제한 전체'
                                      : levelFilter.toString(),
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
