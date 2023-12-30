import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class GganbuPage extends ConsumerWidget {
  const GganbuPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  //깐부
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
                        '레이드/내실\n/일일숙제',
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
                  //고정공대
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
                  //길드
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
                        '길드 찾기\n/길드원 구인',
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
                  //오늘 레이드
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
        ],
      ),
    );
  }
}
