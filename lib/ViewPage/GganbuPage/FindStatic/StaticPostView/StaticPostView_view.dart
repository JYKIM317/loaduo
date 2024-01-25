import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'StaticPostView_widget.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:loaduo/Report/Report_view.dart';

class StaticPostView extends StatefulWidget {
  final Map<String, dynamic> post;
  const StaticPostView({super.key, required this.post});

  @override
  State<StaticPostView> createState() => _StaticPostViewState();
}

class _StaticPostViewState extends State<StaticPostView> {
  late Map<String, dynamic> post;
  String? userUID = FirebaseAuth.instance.currentUser!.uid;
  int pageIndex = 0;

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 44.h),
            if (post['raidLeader'] != userUID)
              Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 16.w),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProgressHUD(
                          child: Report(
                            postType: 'StaticPost',
                            uid: post['raidLeader'],
                            address: post['address'],
                          ),
                        ),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.error,
                    color: Colors.red[400],
                    size: 24.sp,
                  ),
                ),
              ),
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
                    '#고정공대',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18.sp,
                    ),
                  ),
                ],
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
                raid: post['raid'],
                detail: post['detail'],
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
            ),
          ],
        ),
      ),
    );
  }
}
