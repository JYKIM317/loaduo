import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class CreateGuildPost extends StatefulWidget {
  final guildName;
  const CreateGuildPost({super.key, required this.guildName});

  @override
  State<CreateGuildPost> createState() => _CreateGuildPostState();
}

class _CreateGuildPostState extends State<CreateGuildPost> {
  @override
  Widget build(BuildContext context) {
    print(widget.guildName);
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
