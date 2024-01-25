import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'GganbuPostView_widget.dart';
import 'package:loaduo/Report/Report_view.dart';

class GganbuPostView extends StatefulWidget {
  final Map<String, dynamic> post;
  const GganbuPostView({super.key, required this.post});

  @override
  State<GganbuPostView> createState() => _GganbuPostViewState();
}

class _GganbuPostViewState extends State<GganbuPostView> {
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 74.h),
            if (post['uid'] == userUID)
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
                            '내용',
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
                            '대화',
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
            if (post['uid'] == userUID) SizedBox(height: 30.h),
            if (post['uid'] != userUID)
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
                            postType: 'GganbuPost',
                            uid: post['uid'],
                            address: post['uid'],
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
            Expanded(
                child: [
              Detail(
                progress: progress,
                post: post,
              ),
              Conversation(),
              PostSetting(
                progress: progress,
                address: post['uid'],
              ),
            ][pageIndex]),
          ],
        ),
      ),
    );
  }
}
