import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class CreateRaidForTodayPost extends StatefulWidget {
  final myCharacter;
  const CreateRaidForTodayPost({super.key, required this.myCharacter});

  @override
  State<CreateRaidForTodayPost> createState() => _CreateRaidForTodayPostState();
}

class _CreateRaidForTodayPostState extends State<CreateRaidForTodayPost> {
  @override
  Widget build(BuildContext context) {
    print(widget.myCharacter);
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.only(top: 44.h, bottom: 34.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: InkWell(
                onTap: () {},
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
    );
  }
}
