import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:loaduo/ShowToastMsg.dart';
import 'GuildPostView_viewmodel.dart';

class GuildPostView extends StatefulWidget {
  final Map<String, dynamic> post;
  const GuildPostView({super.key, required this.post});

  @override
  State<GuildPostView> createState() => _GuildPostViewState();
}

class _GuildPostViewState extends State<GuildPostView> {
  late Map<String, dynamic> post;
  int pageIndex = 0;
  String? userUID = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    post = widget.post;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final progress = ProgressHUD.of(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color.fromARGB(255, 21, 24, 29).withOpacity(0.9),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                padding: EdgeInsets.only(top: 74.h, bottom: 34.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Text(
                        post['guildName'],
                        style: TextStyle(
                          color: Colors.deepOrange[400],
                          fontSize: 28.sp,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16.w),
                      child: Text.rich(
                        TextSpan(
                          text: '#',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 21.sp,
                          ),
                          children: [
                            TextSpan(
                              text: post['server'],
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 21, 24, 29),
                          borderRadius: BorderRadius.circular(8.sp),
                        ),
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 12.w),
                              child: Text(
                                '길드원을 모집하고있어요!',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24.sp,
                                ),
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Padding(
                              padding: EdgeInsets.only(left: 12.w),
                              child: Text.rich(
                                TextSpan(
                                  text: '우리 길드는 ',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 21.sp,
                                  ),
                                  children: [
                                    const TextSpan(
                                      text: '#',
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    TextSpan(
                                      text: post['guildType'],
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    const TextSpan(
                                      text: ' 예요',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 12.w),
                              child: Text(
                                post['level'] != 0
                                    ? '가입 레벨 제한은 ${post['level']}입니다.'
                                    : '가입 레벨 제한은 없어요',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 21.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 40.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Text(
                        '작성한 내용',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 21, 24, 29),
                          borderRadius: BorderRadius.circular(8.sp),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 16.h,
                        ),
                        child: Text(
                          post['detail'],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 21.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (post['uid'] == userUID)
              Divider(
                color: Colors.grey,
                thickness: 2.h,
                height: 40.h,
              ),
            if (post['uid'] == userUID)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          showDialog(
                              barrierDismissible: true,
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.sp),
                                  ),
                                  backgroundColor: Colors.white,
                                  content: Container(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10.h),
                                    child: Text(
                                      '길드 모집 포스트를\n삭제하시겠습니까?',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                  ),
                                  actionsAlignment: MainAxisAlignment.center,
                                  actions: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            progress?.show();
                                            await GuildPostViewModel()
                                                .removePostData(
                                                    address: post['uid'])
                                                .then((_) {
                                              progress?.dismiss();
                                              Navigator.pop(context);
                                              Navigator.pop(context, true);
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  255, 21, 24, 29),
                                              borderRadius:
                                                  BorderRadius.circular(8.sp),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16.w,
                                                vertical: 8.h),
                                            alignment: Alignment.center,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.check,
                                                  color: Colors.green,
                                                  size: 24.sp,
                                                ),
                                                SizedBox(width: 8.w),
                                                Text(
                                                  '확인',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18.sp,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10.w),
                                        InkWell(
                                          onTap: () => Navigator.pop(context),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  255, 21, 24, 29),
                                              borderRadius:
                                                  BorderRadius.circular(8.sp),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16.w,
                                                vertical: 8.h),
                                            alignment: Alignment.center,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.close,
                                                  color: Colors.red,
                                                  size: 24.sp,
                                                ),
                                                SizedBox(width: 8.w),
                                                Text(
                                                  '취소',
                                                  style: TextStyle(
                                                    color: Colors.white,
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
                                );
                              });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 21.h),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 21, 24, 29),
                            borderRadius: BorderRadius.circular(8.sp),
                          ),
                          child: Text(
                            '포스트 삭제',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          progress?.show();
                          DateTime now = DateTime.now();
                          await GuildPostViewModel()
                              .getPostData(address: post['uid'])
                              .then((postData) async {
                            DateTime postTime = postData['postTime'].toDate();
                            if (postTime.isBefore(
                                now.subtract(const Duration(minutes: 1)))) {
                              await GuildPostViewModel()
                                  .updatePostTime(
                                address: post['uid'],
                                postTime: now,
                              )
                                  .then((_) {
                                Future.microtask(() {
                                  progress?.dismiss();
                                });
                              });
                            } else {
                              progress?.dismiss();
                              showToast('아직 끌어 올릴 수 없습니다.');
                            }
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 21.h),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 21, 24, 29),
                            borderRadius: BorderRadius.circular(8.sp),
                          ),
                          child: Text(
                            '끌어 올림',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            if (post['uid'] == userUID) SizedBox(height: 34.h),
          ],
        ),
      ),
    );
  }
}
