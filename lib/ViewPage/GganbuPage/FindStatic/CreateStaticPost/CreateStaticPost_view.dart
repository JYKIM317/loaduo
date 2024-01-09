import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:bottom_drawer/bottom_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:loaduo/lostark_info.dart';
import 'package:loaduo/ShowToastMsg.dart';

class CreateStaticPost extends StatefulWidget {
  final myCharacter;
  const CreateStaticPost({super.key, required this.myCharacter});

  @override
  State<CreateStaticPost> createState() => _CreateStaticPostState();
}

class _CreateStaticPostState extends State<CreateStaticPost> {
  TextEditingController detailController = TextEditingController();
  String detail = '';

  BottomDrawerController _bottomDrawerController = BottomDrawerController();

  @override
  Widget build(BuildContext context) {
    print(widget.myCharacter);
    final progress = ProgressHUD.of(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        _bottomDrawerController.close();
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          padding: EdgeInsets.only(bottom: 34.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    padding:
                        EdgeInsets.only(top: 64.h, left: 16.w, right: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '고정공대\n모집 글 등록',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 34.sp,
                          ),
                        ),
                        SizedBox(height: 30.h),
                        Text(
                          '목표',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 21.sp,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        SizedBox(height: 30.h),
                        Text(
                          '내용',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 21.sp,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.sp),
                            border: Border.all(
                              color: Colors.grey[400]!,
                              width: 2.sp,
                            ),
                          ),
                          child: TextField(
                            controller: detailController,
                            minLines: 5,
                            maxLines: null,
                            onChanged: (value) {
                              detail = value;
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '작성하고싶은 내용',
                              hintStyle: TextStyle(color: Colors.grey[400]),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
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
      ),
    );
  }
}
