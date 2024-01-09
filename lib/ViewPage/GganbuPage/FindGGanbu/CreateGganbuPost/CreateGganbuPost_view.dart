import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loaduo/ViewPage/GganbuPage/FindGGanbu/CreateGganbuPost/CreateGganbuPost_viewmodel.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:loaduo/CustomIcon.dart';

class CreateGganbuPost extends StatefulWidget {
  final myInfo;
  const CreateGganbuPost({super.key, required this.myInfo});

  @override
  State<CreateGganbuPost> createState() => _CreateGganbuPostState();
}

class _CreateGganbuPostState extends State<CreateGganbuPost> {
  TextEditingController detailController = TextEditingController();
  String? server, skill, character, credential, mood, distribute;
  List<dynamic>? concern;
  int? weekdayTime, weekendTime;
  String detail = '';

  @override
  void initState() {
    character = widget.myInfo['representCharacter'];
    credential = widget.myInfo['credentialCharacter'];
    server = widget.myInfo['representServer'];
    skill = widget.myInfo['raidSkill'];
    mood = widget.myInfo['raidMood'];
    distribute = widget.myInfo['raidDistribute'];
    concern = widget.myInfo['concern'];
    weekdayTime = widget.myInfo['weekdayPlaytime'];
    weekendTime = widget.myInfo['weekendPlaytime'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final progress = ProgressHUD.of(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
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
                          '깐부 구인 등록',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 34.sp,
                          ),
                        ),
                        SizedBox(height: 30.h),
                        Text(
                          '태그',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 21.sp,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      text: '대표 캐릭터',
                                      style: TextStyle(
                                        color: Colors.deepOrange[400],
                                        fontSize: 18.sp,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: ' : ',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18.sp,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '#',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 18.sp,
                                          ),
                                        ),
                                        TextSpan(
                                          text: character,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 2.w),
                                  Icon(
                                    character == credential
                                        ? CustomIcon.check
                                        : CustomIcon.checkEmpty,
                                    color:
                                        const Color.fromARGB(255, 21, 24, 29),
                                    size: 21.sp,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h),
                        SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text.rich(
                                TextSpan(
                                  text: '서버',
                                  style: TextStyle(
                                    color: Colors.deepOrange[400],
                                    fontSize: 18.sp,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: ' : ',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '#',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                    TextSpan(
                                      text: server,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h),
                        SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text.rich(
                                TextSpan(
                                  text: '희망하는 깐부',
                                  style: TextStyle(
                                    color: Colors.deepOrange[400],
                                    fontSize: 18.sp,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: ' : ',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '#',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                    TextSpan(
                                      text: concern
                                          .toString()
                                          .replaceAll(RegExp(r'\[|\]'), ''),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h),
                        SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text.rich(
                                TextSpan(
                                  text: '레이드',
                                  style: TextStyle(
                                    color: Colors.deepOrange[400],
                                    fontSize: 18.sp,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: ' : ',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '#',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                    TextSpan(
                                      text: skill,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' #',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                    TextSpan(
                                      text: mood,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' #',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                    TextSpan(
                                      text: distribute,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h),
                        SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text.rich(
                                TextSpan(
                                  text: '접속 시간대',
                                  style: TextStyle(
                                    color: Colors.deepOrange[400],
                                    fontSize: 18.sp,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: ' : ',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '#평일 ',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '$weekdayTime시',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' #주말 ',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '$weekendTime시',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
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
                  onTap: () async {
                    progress?.show();
                    String? userUID = FirebaseAuth.instance.currentUser!.uid;
                    await CreateGganbuPostViewModel()
                        .uploadPost(
                      uid: userUID,
                      representCharacter: character!,
                      credentialCharacter: credential ?? '',
                      representServer: server!,
                      raidSkill: skill!,
                      raidMood: mood!,
                      raidDistribute: distribute!,
                      concern: concern!,
                      weekdayPlaytime: weekdayTime!,
                      weekendPlaytime: weekendTime!,
                      detail: detail,
                    )
                        .then((_) {
                      progress?.dismiss();
                      Navigator.pop(context);
                    });
                  },
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
