import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:loaduo/ViewPage/InitialDataPages/InitialData/InitialDataPage_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:loaduo/ViewPage/MyPage/AddMyCharacter/AddMyCharacter_view.dart';
import 'package:loaduo/ViewPage/MyPage/MyPage_provider.dart';
import 'MyPage_viewmodel.dart';
import 'package:loaduo/ViewPage/InitialDataPages/InitialData/InitialDataPage_view.dart';
import 'package:loaduo/ViewPage/InitialDataPages/ApiData/ApiDataPage_view.dart';
import 'package:loaduo/ViewPage/UserPage/UserPage_view.dart';
import 'package:loaduo/ShowToastMsg.dart';
import 'package:loaduo/CustomIcon.dart';
import 'package:loaduo/lostark_info.dart';
import 'package:loaduo/ViewPage/GganbuPage/FindGGanbu/GganbuPostView/GganbuPostView_view.dart';
import 'package:loaduo/ViewPage/GganbuPage/FindGuild/GuildPostView/GuildPostView_view.dart';
import 'package:loaduo/ViewPage/GganbuPage/FindRaidForToday/RaidForTodayPostView/RaidForTodayPostView_view.dart';
import 'package:loaduo/ViewPage/GganbuPage/FindStatic/StaticPostView/StaticPostView_view.dart';
import 'package:loaduo/ViewPage/GganbuPage/FindRaidForToday/RaidForTodayPostView/RaidForTodayPostView_viewmodel.dart';
import 'package:loaduo/ViewPage/GganbuPage/FindStatic/StaticPostView/StaticPostView_viewmodel.dart';
import 'package:loaduo/main.dart';

class MyPage extends ConsumerStatefulWidget {
  final String uid;
  const MyPage({super.key, required this.uid});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyPageState();
}

class _MyPageState extends ConsumerState<MyPage> {
  String? userUID = FirebaseAuth.instance.currentUser!.uid;
  late Future postData;
  bool introduce = true, expedition = true;

  @override
  void initState() {
    postData = MyPageViewModel().getUserPost(widget.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final progress = ProgressHUD.of(context);
    bool isMe = widget.uid == userUID;
    final info = isMe ? ref.watch(myPageInfo) : {};
    final characters = isMe ? ref.watch(myPageCharacter) : [];
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.only(top: 44.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isMe)
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                ),
              ),
            SizedBox(height: 20.h),
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
                          ref.read(initialDataIndex.notifier).page0();
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
                Padding(
                  padding: EdgeInsets.only(right: 16.w),
                  child: Row(
                    children: [
                      if (!isMe)
                        IconButton(
                          onPressed: () async {
                            progress?.show();
                            MyPageViewModel()
                                .addBlockedUser(uid: widget.uid)
                                .then((result) {
                              progress?.dismiss();
                              if (result) {
                                ref
                                    .read(blockedUserList.notifier)
                                    .add(widget.uid);
                                showToast('대상을 차단하셨습니다.');
                              } else {
                                showToast('이미 차단 된 대상입니다.');
                              }
                            });
                          },
                          icon: Row(
                            children: [
                              Text(
                                '차단하기',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.sp,
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Icon(
                                Icons.block,
                                size: 24.sp,
                                color: Colors.red,
                              ),
                            ],
                          ),
                        ),
                      if (isMe)
                        IconButton(
                          onPressed: () async {
                            progress?.show();
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            String? _apikey = prefs.getString('apikey');
                            progress?.dismiss();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ApiDataPage(initialApiKey: _apikey),
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
                      IconButton(
                        onPressed: () {
                          setState(() {
                            introduce ? introduce = false : introduce = true;
                          });
                        },
                        icon: Icon(
                          introduce
                              ? Icons.arrow_drop_down_rounded
                              : Icons.arrow_drop_up_rounded,
                          size: 28.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.grey[300],
              thickness: 2.h,
              height: 40.h,
            ),
            //저는요
            SizedBox(
              height: introduce ? null : 0,
              child: FutureBuilder(
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
                    String representCharacter =
                        infoData['representCharacter'] ?? 'rep#';
                    String credentialCharacter =
                        infoData['credentialCharacter'] ?? 'cre#';

                    return Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 12.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            TextSpan(
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  color: Colors.black,
                                ),
                                text: '저는 ',
                                children: <TextSpan>[
                                  TextSpan(
                                    style: TextStyle(
                                        color: Colors.deepOrange[400]),
                                    text: infoData['concern']
                                        .toString()
                                        .replaceAll(
                                            RegExp(r'\[|\]'), ''), //concern
                                  ),
                                  const TextSpan(
                                    text: ' (을)를 해요',
                                  ),
                                  if (infoData['concern'].contains('레이드'))
                                    const TextSpan(
                                      text: '\n저는 레이드를 ',
                                    ),
                                  if (infoData['concern'].contains('레이드'))
                                    TextSpan(
                                      style: TextStyle(
                                          color: Colors.deepOrange[400]),
                                      text: infoData['raidDistribute']
                                          .toString(), //raidDistribute
                                    ),
                                  if (infoData['concern'].contains('레이드'))
                                    const TextSpan(
                                      text: '\n레이드는 주로 ',
                                    ),
                                  if (infoData['concern'].contains('레이드'))
                                    TextSpan(
                                      style: TextStyle(
                                          color: Colors.deepOrange[400]),
                                      text: infoData['raidSkill']
                                          .toString(), //raidSkill
                                    ),
                                  if (infoData['concern'].contains('레이드'))
                                    const TextSpan(
                                      text: ' 파티를 가는 편이고\n레이드를 돌 때는 ',
                                    ),
                                  if (infoData['concern'].contains('레이드'))
                                    TextSpan(
                                      style: TextStyle(
                                          color: Colors.deepOrange[400]),
                                      text: infoData['raidMood']
                                          .toString(), //raidMood
                                    ),
                                  const TextSpan(
                                    text: '\n평일은 ',
                                  ),
                                  TextSpan(
                                    style: TextStyle(
                                        color: Colors.deepOrange[400]),
                                    text: infoData['weekdayPlaytime']
                                        .toString(), //weekdayPlaytime
                                  ),
                                  const TextSpan(
                                    text: '시, 주말은 ',
                                  ),
                                  TextSpan(
                                    style: TextStyle(
                                        color: Colors.deepOrange[400]),
                                    text: infoData['weekendPlaytime']
                                        .toString(), //weekendPlaytime
                                  ),
                                  const TextSpan(
                                    text: '시에\n접속해있는 편이에요',
                                  ),
                                ]),
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(top: 30.h),
                            child: Row(
                              children: [
                                Icon(
                                  representCharacter == credentialCharacter
                                      ? CustomIcon.check
                                      : CustomIcon.checkEmpty,
                                  size: 21.sp,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  representCharacter == credentialCharacter
                                      ? '본캐 인증 완료'
                                      : '본캐 인증 미완료',
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            Container(
              height: 20.h,
              margin: EdgeInsets.symmetric(vertical: 20.h),
              color: Colors.grey[200],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '원정대',
                    style: TextStyle(
                      fontSize: 24.sp,
                      color: Colors.black,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        expedition ? expedition = false : expedition = true;
                      });
                    },
                    icon: Icon(
                      expedition
                          ? Icons.arrow_drop_down_rounded
                          : Icons.arrow_drop_up_rounded,
                      size: 28.sp,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.grey[300],
              thickness: 2.h,
              height: 40.h,
            ),
            //원정대
            SizedBox(
              height: expedition ? null : 0,
              child: Column(
                children: [
                  FutureBuilder(
                      future: isMe
                          ? Future(() => characters.isEmpty
                              ? MyPageViewModel().getUserExpedition(widget.uid)
                              : characters)
                          : MyPageViewModel().getUserExpedition(widget.uid),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                          ref
                              .read(myPageCharacter.notifier)
                              .update(data: expedition);
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
                                          userName: expedition[index]
                                              ['CharacterName'])
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
                                              builder: (context) =>
                                                  ApiDataPage(),
                                            ),
                                          );
                                          break;
                                        case 429:
                                          //API 요청 횟수 제한
                                          showToast('잠시 후 다시 시도해주세요');
                                          break;
                                        case 503:
                                          //API 서비스 점검
                                          showToast(
                                              '로스트아크 API 서비스가 점검중에 있습니다.');
                                          break;
                                        default:
                                          showToast('오류가 발생했습니다.');
                                          break;
                                      }
                                    }
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(
                                      16.w, 14.h, 16.w, 14.h),
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 21, 24, 29),
                                    borderRadius: BorderRadius.circular(8.sp),
                                  ),
                                  child: Text.rich(
                                    TextSpan(
                                        text: expedition[index]
                                            ['CharacterName'],
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
                              info.clear();
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
                    ),
                ],
              ),
            ),
            //참가중인 공격대 및 작성한 포스트
            FutureBuilder(
              future: postData,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 20.h,
                            margin: EdgeInsets.symmetric(vertical: 20.h),
                            color: Colors.grey[200],
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 16.w),
                            child: Text(
                              '참가중인 공격대',
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
                          Container(
                            height: 20.h,
                            margin: EdgeInsets.symmetric(vertical: 20.h),
                            color: Colors.grey[200],
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 16.w),
                            child: Text(
                              '작성한 포스트',
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
                        ],
                      ),
                      CircularProgressIndicator(
                        color: Colors.deepOrange[400],
                      )
                    ],
                  );
                }

                Map<String, dynamic> postList = snapshot.data ?? {};
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 20.h,
                      margin: EdgeInsets.symmetric(vertical: 20.h),
                      color: Colors.grey[200],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16.w),
                      child: Text(
                        '참가중인 공격대',
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
                    if (postList['RaidForTodayPost'] != null)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemCount: postList['RaidForTodayPost'].length,
                          itemBuilder: (BuildContext ctx, int idx) {
                            Map<String, dynamic> post =
                                postList['RaidForTodayPost'][idx];
                            DateTime startTime = post['startTime'].toDate();
                            return InkWell(
                              onTap: () async {
                                //자세히 보기
                                progress?.show();
                                await RaidForTodayPostViewModel()
                                    .getPostData(address: post['address'])
                                    .then((newestPost) async {
                                  progress?.dismiss();
                                  if (newestPost.isNotEmpty) {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProgressHUD(
                                          child: RaidForTodayPostView(
                                              post: newestPost),
                                        ),
                                      ),
                                    ).then((value) {
                                      bool leave = value ?? false;
                                      if (leave) {
                                        setState(() {
                                          postData = MyPageViewModel()
                                              .getUserPost(widget.uid);
                                        });
                                      }
                                    });
                                  } else {
                                    showToast('존재하지 않는 방입니다.');
                                  }
                                });
                              },
                              child: Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 210.h,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.sp),
                                      color:
                                          const Color.fromARGB(255, 21, 24, 29),
                                    ),
                                    padding: EdgeInsets.fromLTRB(
                                        16.w, 20.h, 16.w, 20.h),
                                    child: Stack(
                                      children: [
                                        Opacity(
                                          opacity: 0.2,
                                          child: Transform.translate(
                                            offset: Offset(80.w, 20.h),
                                            child: Transform.scale(
                                              scale: 3,
                                              child: Image.network(
                                                lostarkInfo().networkImage[
                                                    post['raidName']]!,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Container(
                                                      color:
                                                          const Color.fromARGB(
                                                              255, 21, 24, 29));
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    post['detail'],
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 24.sp,
                                                    ),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    '[${post['raidPlayer']}/${post['raidMaxPlayer']}]',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 24.sp,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text.rich(
                                                  TextSpan(
                                                    text: '#',
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 18.sp,
                                                    ),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text:
                                                            '${post['raid']} ',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18.sp,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text.rich(
                                                  TextSpan(
                                                    text: '#',
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 18.sp,
                                                    ),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text:
                                                            '${post['skill']} ',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18.sp,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Text.rich(
                                                  TextSpan(
                                                    text: '#',
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 18.sp,
                                                    ),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text:
                                                            '${startTime.hour}시 ${startTime.minute}분 ',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18.sp,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 50.w,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.w, vertical: 8.h),
                                    margin: EdgeInsets.only(right: 10.w),
                                    decoration: BoxDecoration(
                                      color: Colors.deepOrange[400],
                                      borderRadius: BorderRadius.vertical(
                                        bottom: Radius.circular(8.sp),
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      '오늘',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (ctx, idx) {
                            return SizedBox(height: 10.h);
                          },
                        ),
                      ),
                    if (postList['StaticPost'] != null)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemCount: postList['StaticPost'].length,
                          itemBuilder: (BuildContext ctx, int idx) {
                            Map<String, dynamic> post =
                                postList['StaticPost'][idx];
                            return InkWell(
                              onTap: () async {
                                //자세히 보기
                                progress?.show();
                                await StaticPostViewModel()
                                    .getPostData(address: post['address'])
                                    .then((newestPost) async {
                                  progress?.dismiss();
                                  if (newestPost.isNotEmpty) {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProgressHUD(
                                          child:
                                              StaticPostView(post: newestPost),
                                        ),
                                      ),
                                    ).then((value) {
                                      bool leave = value ?? false;
                                      if (leave) {
                                        setState(() {
                                          postData = MyPageViewModel()
                                              .getUserPost(widget.uid);
                                        });
                                      }
                                    });
                                  } else {
                                    showToast('존재하지 않는 방입니다.');
                                  }
                                });
                              },
                              child: Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 210.h,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.sp),
                                      color:
                                          const Color.fromARGB(255, 21, 24, 29),
                                    ),
                                    padding: EdgeInsets.fromLTRB(
                                        16.w, 20.h, 16.w, 20.h),
                                    child: Stack(
                                      children: [
                                        Opacity(
                                          opacity: 0.2,
                                          child: Transform.translate(
                                            offset: Offset(80.w, 20.h),
                                            child: Transform.scale(
                                              scale: 3,
                                              child: Image.network(
                                                lostarkInfo().networkImage[
                                                    post['raidName']]!,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Container(
                                                      color:
                                                          const Color.fromARGB(
                                                              255, 21, 24, 29));
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    post['detail'],
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 24.sp,
                                                    ),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    '[${post['raidPlayer']}/${post['raidMaxPlayer']}]',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 24.sp,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text.rich(
                                                  TextSpan(
                                                    text: '#',
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 18.sp,
                                                    ),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text: post['raid'],
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18.sp,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 50.w,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.w, vertical: 8.h),
                                    margin: EdgeInsets.only(right: 10.w),
                                    decoration: BoxDecoration(
                                      color: Colors.deepPurple[400],
                                      borderRadius: BorderRadius.vertical(
                                        bottom: Radius.circular(8.sp),
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      '고정',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (ctx, idx) {
                            return SizedBox(height: 10.h);
                          },
                        ),
                      ),
                    Container(
                      height: 20.h,
                      margin: EdgeInsets.symmetric(vertical: 20.h),
                      color: Colors.grey[200],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16.w),
                      child: Text(
                        '작성한 포스트',
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
                    if (postList['GganbuPost'] != null)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: InkWell(
                          onTap: () async {
                            //자세히 보기
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProgressHUD(
                                  child: GganbuPostView(
                                      post: postList['GganbuPost']),
                                ),
                              ),
                            ).then((value) {
                              bool leave = value ?? false;
                              if (leave) {
                                setState(() {
                                  postData =
                                      MyPageViewModel().getUserPost(widget.uid);
                                });
                              }
                            });
                            ;
                          },
                          child: Container(
                            width: double.infinity,
                            height: 210.h,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.sp),
                              color: const Color.fromARGB(255, 21, 24, 29),
                            ),
                            padding:
                                EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 20.h),
                            child: Stack(
                              children: [
                                Opacity(
                                  opacity: 0.2,
                                  child: Transform.translate(
                                    offset: Offset(180.w, 20.h),
                                    child: Transform.scale(
                                      scale: 3,
                                      child: Image.network(
                                        lostarkInfo().networkImage['깐부']!,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Container(
                                              color: const Color.fromARGB(
                                                  255, 21, 24, 29));
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        postList['GganbuPost']['detail'],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 24.sp,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text.rich(
                                          TextSpan(
                                            text: '#',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 18.sp,
                                            ),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text:
                                                    '${postList['GganbuPost']['representServer']} ',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18.sp,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        if (postList['GganbuPost']['concern']
                                                .length >=
                                            1)
                                          Text.rich(
                                            TextSpan(
                                              text: '#',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 18.sp,
                                              ),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text:
                                                      '${postList['GganbuPost']['concern'][0]} ',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18.sp,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        if (postList['GganbuPost']['concern']
                                                .length >=
                                            2)
                                          Text.rich(
                                            TextSpan(
                                              text: '#',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 18.sp,
                                              ),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text:
                                                      '${postList['GganbuPost']['concern'][1]} ',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18.sp,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        if (postList['GganbuPost']['concern']
                                                .length >=
                                            3)
                                          Text.rich(
                                            TextSpan(
                                              text: '#',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 18.sp,
                                              ),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text:
                                                      '${postList['GganbuPost']['concern'][2]} ',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18.sp,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text.rich(
                                          TextSpan(
                                            text: '#',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 18.sp,
                                            ),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text:
                                                    '평일 ${postList['GganbuPost']['weekdayPlaytime']}시 ',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18.sp,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Text.rich(
                                          TextSpan(
                                            text: '#',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 18.sp,
                                            ),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text:
                                                    '주말 ${postList['GganbuPost']['weekendPlaytime']}시 ',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18.sp,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    SizedBox(height: 10.h),
                    if (postList['GuildPost'] != null)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: InkWell(
                          onTap: () async {
                            //자세히 보기
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProgressHUD(
                                  child: GuildPostView(
                                      post: postList['GuildPost']),
                                ),
                              ),
                            ).then((value) {
                              bool leave = value ?? false;
                              if (leave) {
                                setState(() {
                                  postData =
                                      MyPageViewModel().getUserPost(widget.uid);
                                });
                              }
                            });
                          },
                          child: Container(
                            width: double.infinity,
                            height: 210.h,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.sp),
                              color: const Color.fromARGB(255, 21, 24, 29),
                            ),
                            padding:
                                EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 20.h),
                            child: Stack(
                              children: [
                                Opacity(
                                  opacity: 0.2,
                                  child: Transform.translate(
                                    offset: Offset(140.w, 30.h),
                                    child: Transform.scale(
                                      scale: 3,
                                      child: Image.network(
                                        lostarkInfo().networkImage['길드']!,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Container(
                                              color: const Color.fromARGB(
                                                  255, 21, 24, 29));
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      postList['GuildPost']['guildName'],
                                      style: TextStyle(
                                        color: Colors.deepOrange[400],
                                        fontSize: 24.sp,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        postList['GuildPost']['detail'],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.sp,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text.rich(
                                          TextSpan(
                                            text: '#',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 18.sp,
                                            ),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text:
                                                    '${postList['GuildPost']['server']} ',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18.sp,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Text.rich(
                                          TextSpan(
                                            text: '#',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 18.sp,
                                            ),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text:
                                                    '${postList['GuildPost']['guildType']} ',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18.sp,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Text.rich(
                                          TextSpan(
                                            text: '#',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 18.sp,
                                            ),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: postList['GuildPost']
                                                            ['level'] !=
                                                        0
                                                    ? '${postList['GuildPost']['level']} 이상 '
                                                    : '레벨 제한 없음',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18.sp,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
            SizedBox(height: 34.h),
          ],
        ),
      ),
    );
  }
}
