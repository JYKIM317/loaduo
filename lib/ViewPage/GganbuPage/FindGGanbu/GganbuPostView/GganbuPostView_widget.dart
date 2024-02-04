import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:loaduo/ShowToastMsg.dart';
import 'package:loaduo/ViewPage/MyPage/MyPage_view.dart';
import 'GganbuPostView_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loaduo/ViewPage/MyPage/MyPage_viewmodel.dart';
import 'package:loaduo/ViewPage/ChattingPage/ChattingPage_view.dart';

class Detail extends StatelessWidget {
  final Map<String, dynamic> post;
  final progress;
  const Detail({
    super.key,
    required this.progress,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    String? userUID = FirebaseAuth.instance.currentUser!.uid;
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.only(top: 20.h, bottom: 34.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text(
                      '소개',
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '안녕하세요!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 21.sp,
                            ),
                          ),
                          Text(
                            '${post['representServer']} 서버의 ${post['representCharacter']}입니다.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 21.sp,
                            ),
                          ),
                          Text(
                            '${post['concern'].toString().replaceAll(RegExp(r"\[|\]"), '')} 깐부를 구하고있어요',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 21.sp,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          if (post['concern'].contains('레이드'))
                            Text(
                              '레이드는 ${post['raidSkill']}(으)로 ${post['raidDistribute']}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 21.sp,
                              ),
                            ),
                          if (post['concern'].contains('레이드'))
                            Text(
                              '레이드를 돌 때는 ${post['raidMood']}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 21.sp,
                              ),
                            ),
                          Text(
                            '보통 평일에는 ${post['weekdayPlaytime']}시 주말에는 ${post['weekendPlaytime']}시에 접속하는 편입니다.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 21.sp,
                            ),
                          ),
                          Text(
                            '저와 맞는다고 생각하시면 대화 나눠봐요!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 21.sp,
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            '제 원정대를 보시려면',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 21.sp,
                            ),
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (conetxt) => Material(
                                        child: ProgressHUD(
                                          child: MyPage(
                                            uid: post['uid'],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.deepOrange[400],
                                    borderRadius: BorderRadius.circular(8.sp),
                                  ),
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                    vertical: 4.h,
                                  ),
                                  child: Text(
                                    '여기',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.sp,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                ' 를 눌러주세요!',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 21.sp,
                                ),
                              ),
                            ],
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
          if (post['uid'] != userUID)
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 25.h),
              child: InkWell(
                onTap: () async {
                  progress?.show();
                  Map<String, dynamic> userData =
                      await MyPageViewModel().getUserInfo(userUID);
                  if (userData['representServer'] != null &&
                      userData['representCharacter'] != null) {
                    //대화 있는지 검사 후 없으면 생성하는 로직
                    await GganbuPostViewModel()
                        .existConversation(
                      address: post['uid'],
                      uid: userUID,
                      post: post,
                      requestUserData: userData,
                    )
                        .then((_) async {
                      await GganbuPostViewModel()
                          .getChattingInfo(
                        address: post['uid'],
                        uid: userUID,
                      )
                          .then((info) {
                        progress?.dismiss();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChattingPage(
                              address:
                                  'Chatting/Gganbu/${post['uid']}/$userUID/Messages',
                              info: info[userUID],
                              otherPersonInfo: info[post['uid']],
                              members: info.keys.toList(),
                            ),
                            settings: const RouteSettings(name: 'ChattingPage'),
                          ),
                        );
                      });
                    });
                  } else {
                    progress?.dismiss();
                    showToast('내 원정대를 등록해주세요\n[내 정보] - [내 원정대 등록하기]');
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 21.h),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 21, 24, 29),
                    borderRadius: BorderRadius.circular(8.sp),
                  ),
                  child: Text(
                    '대화하기',
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
    );
  }
}

class PostSetting extends StatefulWidget {
  final String address;
  final progress;
  const PostSetting({
    super.key,
    required this.address,
    required this.progress,
  });

  @override
  State<PostSetting> createState() => _PostSettingState();
}

class _PostSettingState extends State<PostSetting> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 40.h),
        child: FutureBuilder(
          future: GganbuPostViewModel().getPostData(address: widget.address),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox(
                height: 246.h,
                child: Center(
                    child: CircularProgressIndicator(
                  color: Colors.deepOrange[400],
                )),
              );
            }
            Map<String, dynamic> post = snapshot.data;
            DateTime postTime = post['postTime'].toDate();
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '가장 최근 끌어올린 시간',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  postTime.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 40.h),
                InkWell(
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
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              child: Text(
                                '깐부 찾기 포스트를\n삭제하시겠습니까?',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ),
                            actionsAlignment: MainAxisAlignment.center,
                            actions: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      widget.progress?.show();
                                      await GganbuPostViewModel()
                                          .removePostData(address: post['uid'])
                                          .then((_) {
                                        widget.progress?.dismiss();
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
                                          horizontal: 16.w, vertical: 8.h),
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
                                          horizontal: 16.w, vertical: 8.h),
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
                SizedBox(height: 20.h),
                InkWell(
                  onTap: () async {
                    DateTime now = DateTime.now();
                    if (postTime
                        .isBefore(now.subtract(const Duration(minutes: 1)))) {
                      widget.progress?.show();
                      await GganbuPostViewModel()
                          .updatePostTime(
                        address: widget.address,
                        postTime: now,
                      )
                          .then((_) {
                        Future.microtask(() {
                          widget.progress?.dismiss();
                          setState(() {});
                        });
                      });
                    } else {
                      showToast('아직 끌어 올릴 수 없습니다.');
                    }
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
              ],
            );
          },
        ));
  }
}
