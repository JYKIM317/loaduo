import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:bottom_drawer/bottom_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loaduo/ViewPage/GganbuPage/FindGuild/CreateGuildPost/CreateGuildPost_viewmodel.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:loaduo/lostark_info.dart';
import 'package:loaduo/ShowToastMsg.dart';

class CreateGuildPost extends StatefulWidget {
  final guildName;
  final server;
  const CreateGuildPost(
      {super.key, required this.guildName, required this.server});

  @override
  State<CreateGuildPost> createState() => _CreateGuildPostState();
}

class _CreateGuildPostState extends State<CreateGuildPost> {
  TextEditingController detailController = TextEditingController();
  late String guild, server;
  String detail = '', type = '자유길드';
  int? level;
  int drawerIndex = 0;

  List<String> typeList = ['자유길드', '친목길드', '혈석길드', 'PvP길드'];
  TextEditingController levelController = TextEditingController();
  int? inputLevel;

  BottomDrawerController _bottomDrawerController = BottomDrawerController();

  typeDrawer() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.only(bottom: 34.h),
              itemCount: typeList.length,
              itemBuilder: (BuildContext ctx, int idx) {
                String typeName = typeList[idx];
                return TextButton(
                  onPressed: () {
                    setState(() {
                      type = typeName;
                    });
                    _bottomDrawerController.close();
                  },
                  child: Text(
                    typeName,
                    style: TextStyle(
                      color: type == typeName
                          ? Colors.deepOrange[400]
                          : Colors.black,
                      fontSize: 24.sp,
                    ),
                  ),
                );
              },
              separatorBuilder: (ctx, idx) {
                return SizedBox(height: 10.h);
              },
            ),
          ),
        ],
      ),
    );
  }

  levelDrawer() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 34.h),
      child: Material(
        color: Colors.grey[100],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 140.w,
                  child: TextField(
                    controller: levelController,
                    onChanged: (value) {
                      inputLevel = int.parse(value);
                    },
                    maxLines: 1,
                    minLines: 1,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24.sp),
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: '아이템 레벨',
                      hintStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                Text(
                  '이상',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24.sp,
                  ),
                ),
              ],
            )),
            InkWell(
              onTap: () {
                if (inputLevel != null) {
                  if (inputLevel! <= lostarkInfo().maxLevel &&
                      inputLevel! >= 0) {
                    if (inputLevel! < 1000) {
                      inputLevel = null;
                    }
                    setState(() {
                      level = inputLevel;
                    });
                    _bottomDrawerController.close();
                  } else {
                    showToast('입력하신 레벨의 범위가 잘못되었습니다.');
                  }
                } else {
                  showToast('제한 레벨을 입력해주세요');
                }
              },
              child: Container(
                width: double.infinity,
                height: 80.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.sp),
                  color: Colors.deepOrange[400],
                ),
                child: Text(
                  '레벨 제한 설정하기',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomDrawer(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BottomDrawer(
        controller: _bottomDrawerController,
        header: const SizedBox(height: 0),
        cornerRadius: 16.sp,
        color: Colors.grey[100]!,
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            blurRadius: 1,
          )
        ],
        body: [
          typeDrawer(),
          levelDrawer(),
        ][drawerIndex],
        headerHeight: 0,
        drawerHeight: 472.h,
      ),
    );
  }

  @override
  void initState() {
    guild = widget.guildName;
    server = widget.server;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final progress = ProgressHUD.of(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        _bottomDrawerController.close();
      },
      child: Stack(
        children: [
          Scaffold(
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
                              '길드원 모집 등록',
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
                                      text: '길드명',
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
                                          text: guild,
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
                              child: Row(
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      text: '길드 유형',
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
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 4.w),
                                  InkWell(
                                    onTap: () {
                                      FocusScope.of(context).unfocus();
                                      _bottomDrawerController.close();
                                      setState(() {
                                        drawerIndex = 0;
                                      });
                                      _bottomDrawerController.open();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.fromLTRB(
                                          8.w, 4.h, 8.w, 4.h),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.sp),
                                        color: Colors.grey,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            type,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.sp,
                                            ),
                                          ),
                                          SizedBox(width: 4.w),
                                          Icon(
                                            Icons.arrow_drop_down_rounded,
                                            color: Colors.white,
                                            size: 24.sp,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10.h),
                            SizedBox(
                              width: double.infinity,
                              child: Row(
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      text: '레벨 제한',
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
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 4.w),
                                  InkWell(
                                    onTap: () {
                                      FocusScope.of(context).unfocus();
                                      _bottomDrawerController.close();
                                      setState(() {
                                        drawerIndex = 1;
                                      });
                                      _bottomDrawerController.open();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.fromLTRB(
                                          8.w, 4.h, 8.w, 4.h),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.sp),
                                        color: Colors.grey,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            level == null
                                                ? '레벨 제한 없음'
                                                : '$level 이상',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.sp,
                                            ),
                                          ),
                                          SizedBox(width: 4.w),
                                          Icon(
                                            Icons.arrow_drop_down_rounded,
                                            color: Colors.white,
                                            size: 24.sp,
                                          ),
                                        ],
                                      ),
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
                                  hintText: '길드 설명 및 작성하고싶은 내용',
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
                        String? userUID =
                            FirebaseAuth.instance.currentUser!.uid;
                        await CreateGuildPostViewModel()
                            .uploadPost(
                          uid: userUID,
                          server: server,
                          guildName: guild,
                          guildType: type,
                          level: level,
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
          bottomDrawer(context),
        ],
      ),
    );
  }
}
