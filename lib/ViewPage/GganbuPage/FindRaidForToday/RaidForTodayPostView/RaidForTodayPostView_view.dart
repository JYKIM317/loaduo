import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'RaidForTodayPostView_widget.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

class RaidForTodayPostView extends StatefulWidget {
  final Map<String, dynamic> post;
  const RaidForTodayPostView({super.key, required this.post});

  @override
  State<RaidForTodayPostView> createState() => _RaidForTodayPostViewState();
}

class _RaidForTodayPostViewState extends State<RaidForTodayPostView> {
  late Map<String, dynamic> post;
  String? userUID = FirebaseAuth.instance.currentUser!.uid;
  int pageIndex = 0;
  late DateTime startTime;

  @override
  void initState() {
    post = widget.post;
    startTime = post['startTime'].toDate();
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 44.h),
            Container(
              width: double.infinity,
              height: 100.h,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${post['raid']}  파티 모집',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.sp,
                    ),
                  ),
                  Text(
                    '#${post['skill']}  #${startTime.hour}시 ${startTime.minute}분',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18.sp,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 32.h),
              alignment: Alignment.centerLeft,
              child: Text(
                '${post['detail']}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                ),
              ),
            ),
            if (post['raidLeader'] == userUID)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          if (pageIndex != 0) {
                            setState(() {
                              pageIndex = 0;
                            });
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 21, 24, 29),
                            boxShadow: [
                              if (pageIndex == 0)
                                BoxShadow(
                                  color: Colors.deepOrange[400]!,
                                  blurRadius: 4,
                                ),
                            ],
                          ),
                          child: Text(
                            '참가자',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          if (pageIndex != 1) {
                            setState(() {
                              pageIndex = 1;
                            });
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 21, 24, 29),
                            boxShadow: [
                              if (pageIndex == 1)
                                BoxShadow(
                                  color: Colors.deepOrange[400]!,
                                  blurRadius: 4,
                                ),
                            ],
                          ),
                          child: Text(
                            '신청자',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          if (pageIndex != 2) {
                            setState(() {
                              pageIndex = 2;
                            });
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 21, 24, 29),
                            boxShadow: [
                              if (pageIndex == 2)
                                BoxShadow(
                                  color: Colors.deepOrange[400]!,
                                  blurRadius: 4,
                                ),
                            ],
                          ),
                          child: Text(
                            '모집 설정',
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
            SizedBox(height: 20.h),
            Expanded(
                child: [
              JoinUser(
                address: post['address'],
                leader: post['raidLeader'],
                progress: progress,
              ),
              RequestUser(
                address: post['address'],
                progress: progress,
              ),
              PostSetting(
                address: post['address'],
                progress: progress,
              ),
            ][pageIndex]),
            SizedBox(
              height: 34.h,
            )
          ],
        ),
      ),
    );
  }
}
