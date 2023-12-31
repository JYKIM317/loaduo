import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

import 'package:loaduo/ViewPage/MyPage/AddMyCharacter/AddMyCharacter_view.dart';
import 'package:loaduo/ViewPage/MyPage/MyPage_provider.dart';
import 'MyPage_viewmodel.dart';
import 'package:loaduo/ViewPage/InitialDataPages/InitialData/InitialDataPage_view.dart';
import 'package:loaduo/ViewPage/InitialDataPages/ApiData/ApiDataPage_view.dart';
import 'package:loaduo/ViewPage/UserPage/UserPage_view.dart';
import 'package:loaduo/ShowToastMsg.dart';

class MyPage extends ConsumerStatefulWidget {
  final String uid;
  const MyPage({super.key, required this.uid});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyPageState();
}

class _MyPageState extends ConsumerState<MyPage> {
  String? userUID = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    final progress = ProgressHUD.of(context);
    bool isMe = widget.uid == userUID;
    final info = isMe ? ref.watch(myPageInfo) : {};
    final characters = isMe ? ref.watch(myPageCharacter) : [];
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.only(top: 44.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 40.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 16.w),
                    child: Text(
                      '저는요',
                      style: TextStyle(
                        fontSize: 24.sp,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  if (isMe)
                    IconButton(
                      onPressed: () {
                        ref.read(myPageInfo.notifier).remove();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InitialDataPage(),
                          ),
                        );
                      },
                      icon: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.fromLTRB(6.w, 4.h, 6.w, 4.h),
                        decoration: BoxDecoration(
                          color: Colors.deepOrange[200],
                          borderRadius: BorderRadius.circular(8.sp),
                        ),
                        child: Text(
                          '수정하기',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              if (isMe)
                Padding(
                  padding: EdgeInsets.only(right: 16.w),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ApiDataPage(),
                        ),
                      );
                    },
                    icon: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.fromLTRB(6.w, 4.h, 6.w, 4.h),
                      decoration: BoxDecoration(
                        color: Colors.deepOrange[400],
                        borderRadius: BorderRadius.circular(8.sp),
                      ),
                      child: Text(
                        'API Key',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Divider(
            color: Colors.grey[300],
            thickness: 2.h,
            height: 40.h,
          ),
          FutureBuilder(
              future: isMe
                  ? Future(() => info.isEmpty
                      ? MyPageViewModel().getUserInfo(widget.uid)
                      : info)
                  : MyPageViewModel().getUserInfo(widget.uid),
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
                Map<String, dynamic>? infoData = snapshot.data;
                infoData ??= {};
                //내 MyPage 첫 접속 시 provider에 내 정보 저장
                if (isMe && info.isEmpty) {
                  ref.read(myPageInfo.notifier).update(data: infoData);
                }

                return Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  child: Text.rich(
                    TextSpan(
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: Colors.black,
                        ),
                        text: '저는 ',
                        children: <TextSpan>[
                          TextSpan(
                            style: TextStyle(color: Colors.deepOrange[400]),
                            text: infoData['concern'].toString(), //concern
                          ),
                          const TextSpan(
                            text: ' 깐부를 찾고 있어요\n저는 레이드를 ',
                          ),
                          TextSpan(
                            style: TextStyle(color: Colors.deepOrange[400]),
                            text: infoData['raidDistribute']
                                .toString(), //raidDistribute
                          ),
                          const TextSpan(
                            text: '\n레이드는 주로 ',
                          ),
                          TextSpan(
                            style: TextStyle(color: Colors.deepOrange[400]),
                            text: infoData['raidSkill'].toString(), //raidSkill
                          ),
                          const TextSpan(
                            text: ' 파티를 가는 편이고\n레이드를 돌 때는 ',
                          ),
                          TextSpan(
                            style: TextStyle(color: Colors.deepOrange[400]),
                            text: infoData['raidMood'].toString(), //raidMood
                          ),
                          const TextSpan(
                            text: '\n평일은 ',
                          ),
                          TextSpan(
                            style: TextStyle(color: Colors.deepOrange[400]),
                            text: infoData['weekdayPlaytime']
                                .toString(), //weekdayPlaytime
                          ),
                          const TextSpan(
                            text: '시, 주말은 ',
                          ),
                          TextSpan(
                            style: TextStyle(color: Colors.deepOrange[400]),
                            text: infoData['weekendPlaytime']
                                .toString(), //weekendPlaytime
                          ),
                          const TextSpan(
                            text: '시에\n접속해있는 편이에요',
                          ),
                        ]),
                  ),
                );
              }),
          Container(
            height: 20.h,
            margin: EdgeInsets.symmetric(vertical: 20.h),
            color: Colors.grey[200],
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.w),
            child: Text(
              '캐릭터',
              style: TextStyle(
                fontSize: 24.sp,
                color: Colors.black,
              ),
            ),
          ),
          Divider(
            color: Colors.grey[300],
            thickness: 2.h,
            height: 40.h,
          ),
          FutureBuilder(
              future: isMe
                  ? Future(() => characters.isEmpty
                      ? MyPageViewModel().getUserExpedition(widget.uid)
                      : characters)
                  : MyPageViewModel().getUserExpedition(widget.uid),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    height: 200.h,
                    child: Center(
                        child: CircularProgressIndicator(
                      color: Colors.deepOrange[400],
                    )),
                  );
                }
                List<dynamic> expedition = snapshot.data;

                if (isMe && characters.isEmpty) {
                  ref.read(myPageCharacter.notifier).update(data: expedition);
                }
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.only(bottom: 10.h),
                    itemCount: expedition.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
                          progress?.show();
                          await MyPageViewModel()
                              .getCharacterData(
                                  userName: expedition[index]['CharacterName'])
                              .then((result) {
                            Future.microtask(() {
                              progress?.dismiss();
                            });
                            if (result != null) {
                              switch (result['statusCode']) {
                                case 200:
                                  //요청 성공
                                  if (result['body'] != null) {
                                    //캐릭터 반환 성공
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => UserPage(
                                          userData: result['body'],
                                        ),
                                      ),
                                    );
                                  } else {
                                    showToast(
                                        '${expedition[index]['CharacterName']}\n캐릭터 정보가 없습니다.');
                                  }
                                  break;
                                case 401:
                                  showToast('API Key가 정상적이지 않습니다.');
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ApiDataPage(),
                                    ),
                                  );
                                  break;
                                case 429:
                                  //API 요청 횟수 제한
                                  showToast('잠시 후 다시 시도해주세요');
                                  break;
                                case 503:
                                  //API 서비스 점검
                                  showToast('로스트아크 API 서비스가 점검중에 있습니다.');
                                  break;
                                default:
                                  showToast('오류가 발생했습니다.');
                                  break;
                              }
                            }
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 14.h),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 21, 24, 29),
                            borderRadius: BorderRadius.circular(8.sp),
                          ),
                          child: Text.rich(
                            TextSpan(
                                text: expedition[index]['CharacterName'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.sp,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text:
                                        ' ${expedition[index]['ItemAvgLevel']}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '\n클래스 ',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        '${expedition[index]['CharacterClassName']}',
                                  ),
                                  TextSpan(
                                    text: '  캐릭터 레벨 ',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        '${expedition[index]['CharacterLevel']}',
                                  ),
                                ]),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 10.h);
                    },
                  ),
                );
              }),
          if (isMe)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: IconButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProgressHUD(child: AddMyCharacter()),
                    ),
                  ).then((change) {
                    if (change != null && change) {
                      ref.read(myPageCharacter.notifier).remove();
                      setState(() {});
                    }
                  });
                },
                icon: Container(
                  width: double.infinity,
                  height: 70.h,
                  alignment: Alignment.center,
                  padding: EdgeInsets.fromLTRB(10.w, 8.h, 10.w, 8.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.sp),
                    color: Colors.deepOrange[400],
                  ),
                  child: Text(
                    characters.isEmpty ? '내 원정대 등록하기' : '내 원정대 변경하기',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.sp,
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
