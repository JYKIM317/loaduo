import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:bottom_drawer/bottom_drawer.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:loaduo/lostark_info.dart';
import 'package:loaduo/ShowToastMsg.dart';
import 'CreateStaticPost_viewmodel.dart';

class CreateStaticPost extends StatefulWidget {
  final myCharacter;
  const CreateStaticPost({super.key, required this.myCharacter});

  @override
  State<CreateStaticPost> createState() => _CreateStaticPostState();
}

class _CreateStaticPostState extends State<CreateStaticPost> {
  TextEditingController detailController = TextEditingController();
  String? raid, raidElement;
  String detail = '';

  bool legionRaidSelect = false;
  String? legeionElement;
  bool abyssDungeonSelect = false;
  String? abyssElement;
  bool kazerosRaidSelect = false;
  String? kazerosElement;
  int? raidMaxPlayer;

  BottomDrawerController _bottomDrawerController = BottomDrawerController();

  late Map<String, dynamic> myCharacter;

  @override
  void initState() {
    myCharacter = widget.myCharacter;
    super.initState();
  }

  raidDrawer() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 0),
      child: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 34.h),
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //군단장 레이드
            TextButton(
              onPressed: () {
                setState(() {
                  legionRaidSelect
                      ? legionRaidSelect = false
                      : legionRaidSelect = true;
                });
              },
              child: Text(
                '군단장 레이드',
                style: TextStyle(
                  color:
                      legionRaidSelect ? Colors.deepOrange[400] : Colors.black,
                  fontSize: 24.sp,
                ),
              ),
            ),
            if (legionRaidSelect)
              Padding(
                padding: EdgeInsets.only(left: 16.w),
                child: SizedBox(
                  height: 60.h,
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: lostarkInfo().legionRaidList.length,
                    itemBuilder: (BuildContext ctx, int idx) {
                      return TextButton(
                        onPressed: () {
                          setState(() {
                            if (legeionElement ==
                                lostarkInfo().legionRaidList[idx]) {
                              legeionElement = null;
                            } else {
                              legeionElement =
                                  lostarkInfo().legionRaidList[idx];
                            }
                          });
                        },
                        child: Text(
                          lostarkInfo().legionRaidList[idx],
                          style: TextStyle(
                            color: legeionElement ==
                                    lostarkInfo().legionRaidList[idx]
                                ? Colors.deepOrange[400]
                                : Colors.black,
                            fontSize: 24.sp,
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (ctx, idx) {
                      return SizedBox(width: 10.w);
                    },
                  ),
                ),
              ),
            if (legionRaidSelect && legeionElement != null)
              Padding(
                padding: EdgeInsets.only(left: 32.w),
                child: SizedBox(
                  height: 60.h,
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount:
                        lostarkInfo().raidDifficulty[legeionElement].length,
                    itemBuilder: (BuildContext ctx, int idx) {
                      return TextButton(
                        onPressed: () {
                          setState(() {
                            raid =
                                '$legeionElement ${lostarkInfo().raidDifficulty[legeionElement][idx]}';
                            raidMaxPlayer =
                                lostarkInfo().raidMaxPlayer[legeionElement];
                            raidElement = legeionElement;
                          });
                          _bottomDrawerController.close();
                        },
                        child: Text(
                          lostarkInfo().raidDifficulty[legeionElement][idx],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24.sp,
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (ctx, idx) {
                      return SizedBox(width: 10.w);
                    },
                  ),
                ),
              ),
            SizedBox(height: 20.h),
            //어비스 던전
            TextButton(
              onPressed: () {
                setState(() {
                  abyssDungeonSelect
                      ? abyssDungeonSelect = false
                      : abyssDungeonSelect = true;
                });
              },
              child: Text(
                '어비스 던전',
                style: TextStyle(
                  color: abyssDungeonSelect
                      ? Colors.deepOrange[400]
                      : Colors.black,
                  fontSize: 24.sp,
                ),
              ),
            ),
            if (abyssDungeonSelect)
              Padding(
                padding: EdgeInsets.only(left: 16.w),
                child: SizedBox(
                  height: 60.h,
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: lostarkInfo().abyssDungeonList.length,
                    itemBuilder: (BuildContext ctx, int idx) {
                      return TextButton(
                        onPressed: () {
                          setState(() {
                            if (abyssElement ==
                                lostarkInfo().abyssDungeonList[idx]) {
                              abyssElement = null;
                            } else {
                              abyssElement =
                                  lostarkInfo().abyssDungeonList[idx];
                            }
                          });
                        },
                        child: Text(
                          lostarkInfo().abyssDungeonList[idx],
                          style: TextStyle(
                            color: abyssElement ==
                                    lostarkInfo().abyssDungeonList[idx]
                                ? Colors.deepOrange[400]
                                : Colors.black,
                            fontSize: 24.sp,
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (ctx, idx) {
                      return SizedBox(width: 10.w);
                    },
                  ),
                ),
              ),
            if (abyssDungeonSelect && abyssElement != null)
              Padding(
                padding: EdgeInsets.only(left: 32.w),
                child: SizedBox(
                  height: 60.h,
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount:
                        lostarkInfo().raidDifficulty[abyssElement].length,
                    itemBuilder: (BuildContext ctx, int idx) {
                      return TextButton(
                        onPressed: () {
                          setState(() {
                            raid =
                                '$abyssElement ${lostarkInfo().raidDifficulty[abyssElement][idx]}';
                            raidMaxPlayer =
                                lostarkInfo().raidMaxPlayer[abyssElement];
                            raidElement = abyssElement;
                          });
                          _bottomDrawerController.close();
                        },
                        child: Text(
                          lostarkInfo().raidDifficulty[abyssElement][idx],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24.sp,
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (ctx, idx) {
                      return SizedBox(width: 10.w);
                    },
                  ),
                ),
              ),
            SizedBox(height: 20.h),
            //카제로스 레이드
            TextButton(
              onPressed: () {
                setState(() {
                  kazerosRaidSelect
                      ? kazerosRaidSelect = false
                      : kazerosRaidSelect = true;
                });
              },
              child: Text(
                '카제로스 레이드',
                style: TextStyle(
                  color:
                      kazerosRaidSelect ? Colors.deepOrange[400] : Colors.black,
                  fontSize: 24.sp,
                ),
              ),
            ),
            if (kazerosRaidSelect)
              Padding(
                padding: EdgeInsets.only(left: 16.w),
                child: SizedBox(
                  height: 60.h,
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: lostarkInfo().kazerosRaidList.length,
                    itemBuilder: (BuildContext ctx, int idx) {
                      return TextButton(
                        onPressed: () {
                          setState(() {
                            if (kazerosElement ==
                                lostarkInfo().kazerosRaidList[idx]) {
                              kazerosElement = null;
                            } else {
                              kazerosElement =
                                  lostarkInfo().kazerosRaidList[idx];
                            }
                          });
                        },
                        child: Text(
                          lostarkInfo().kazerosRaidList[idx],
                          style: TextStyle(
                            color: kazerosElement ==
                                    lostarkInfo().kazerosRaidList[idx]
                                ? Colors.deepOrange[400]
                                : Colors.black,
                            fontSize: 24.sp,
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (ctx, idx) {
                      return SizedBox(width: 10.w);
                    },
                  ),
                ),
              ),
            if (kazerosRaidSelect && kazerosElement != null)
              Padding(
                padding: EdgeInsets.only(left: 32.w),
                child: SizedBox(
                  height: 60.h,
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount:
                        lostarkInfo().raidDifficulty[kazerosElement].length,
                    itemBuilder: (BuildContext ctx, int idx) {
                      return TextButton(
                        onPressed: () {
                          setState(() {
                            raid =
                                '$kazerosElement ${lostarkInfo().raidDifficulty[kazerosElement][idx]}';
                            raidMaxPlayer =
                                lostarkInfo().raidMaxPlayer[kazerosElement];
                            raidElement = kazerosElement;
                          });
                          _bottomDrawerController.close();
                        },
                        child: Text(
                          lostarkInfo().raidDifficulty[kazerosElement][idx],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24.sp,
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (ctx, idx) {
                      return SizedBox(width: 10.w);
                    },
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
        body: raidDrawer(),
        headerHeight: 0,
        drawerHeight: 472.h,
      ),
    );
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
                            SizedBox(
                              width: double.infinity,
                              child: Row(
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
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 4.w),
                                  InkWell(
                                    onTap: () {
                                      FocusScope.of(context).unfocus();
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
                                            raid == null ? '레이드 선택' : raid!,
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
                        if (raid != null &&
                            raidMaxPlayer != null &&
                            raidElement != null) {
                          int myLevel = double.parse(myCharacter['ItemMaxLevel']
                                  .replaceAll(',', ''))
                              .toInt();
                          if (myLevel >= lostarkInfo().raidLevel[raid]) {
                            progress?.show();
                            await CreateStaticPostViewModel()
                                .uploadPost(
                              raidLeader: myCharacter['uid'],
                              raid: raid!,
                              raidName: raidElement!,
                              raidMaxPlayer: raidMaxPlayer!,
                              detail: detail,
                              myCharacter: myCharacter,
                            )
                                .then((_) {
                              progress?.dismiss();
                              Navigator.pop(context);
                            });
                          } else {
                            showToast('선택하신 캐릭터의 레벨이\n레이드 입장 레벨보다 낮습니다.');
                          }
                        } else {
                          showToast('목표 레이드를 설정하지 않았습니다.');
                        }
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
