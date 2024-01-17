import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'RaidForTodayPostView_viewmodel.dart';
import 'package:loaduo/lostark_info.dart';
import 'package:loaduo/CustomIcon.dart';
import 'package:loaduo/ShowToastMsg.dart';
import 'package:loaduo/ViewPage/MyPage/MyPage_viewmodel.dart';
import 'package:loaduo/ViewPage/GganbuPage/MyExpedition_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loaduo/ViewPage/UserPage/UserPage_view.dart';
import 'package:loaduo/ViewPage/MyPage/MyPage_view.dart';
import 'package:loaduo/ViewPage/SearchUserPage/SearchUserPage_viewmodel.dart';
import 'package:loaduo/ViewPage/InitialDataPages/ApiData/ApiDataPage_view.dart';

class JoinUser extends StatelessWidget {
  final String address, leader, raid;
  final progress;
  const JoinUser({
    super.key,
    required this.address,
    required this.leader,
    required this.progress,
    required this.raid,
  });

  @override
  Widget build(BuildContext context) {
    String? userUID = FirebaseAuth.instance.currentUser!.uid;
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SizedBox(
              child: FutureBuilder(
                future: RaidForTodayPostViewModel()
                    .getJoinCharacterList(address: address),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(
                      height: 246.h,
                      child: Center(
                          child: CircularProgressIndicator(
                        color: Colors.deepOrange[400],
                      )),
                    );
                  }
                  List<Map<String, dynamic>> joinCharacterList =
                      snapshot.data ?? [];
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 10.h),
                    itemCount: joinCharacterList.length,
                    itemBuilder: (BuildContext ctx, int idx) {
                      Map<String, dynamic> character = joinCharacterList[idx];
                      return InkWell(
                        onTap: () {
                          //캐릭터 페이지 or 원정대 페이지
                          showDialog(
                            barrierDismissible: true,
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.sp),
                                ),
                                backgroundColor: Colors.white,
                                alignment: Alignment.center,
                                content: Container(
                                  padding: EdgeInsets.symmetric(vertical: 10.h),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          progress?.show();
                                          await SearchUserPageViewModel()
                                              .searchUser(
                                                  userName: character[
                                                      'CharacterName'])
                                              .then((result) {
                                            progress?.dismiss();
                                            Navigator.pop(context);
                                            if (result != null) {
                                              switch (result['statusCode']) {
                                                case 200:
                                                  //요청 성공
                                                  if (result['body'] != null) {
                                                    //캐릭터 반환 성공

                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            UserPage(
                                                          userData:
                                                              result['body'],
                                                        ),
                                                      ),
                                                    );
                                                  } else {
                                                    showToast(
                                                        '${character['CharacterName']}\n캐릭터 정보가 없습니다.');
                                                  }
                                                  break;
                                                case 401:
                                                  showToast(
                                                      'API Key가 정상적이지 않습니다.');
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
                                          width: double.infinity,
                                          height: 100.h,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 21, 24, 29),
                                            borderRadius:
                                                BorderRadius.circular(8.sp),
                                          ),
                                          child: Text(
                                            '캐릭터 정보',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (conetxt) => Material(
                                                child: ProgressHUD(
                                                  child: MyPage(
                                                    uid: character['uid'],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          height: 100.h,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 21, 24, 29),
                                            borderRadius:
                                                BorderRadius.circular(8.sp),
                                          ),
                                          child: Text(
                                            '원정대 정보',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 8.h),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 21, 24, 29),
                            borderRadius: BorderRadius.circular(8.sp),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (character['uid'] == leader)
                                Icon(
                                  CustomIcon.crown,
                                  size: 14.sp,
                                  color: Colors.amber,
                                ),
                              if (character['uid'] == leader)
                                SizedBox(width: 12.w),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    lostarkInfo().classIcon[
                                        character['CharacterClassName']],
                                    color: Colors.white,
                                    size: 34.sp,
                                  ),
                                  SizedBox(height: 2.h),
                                  Text(
                                    'Lv.${character['CharacterLevel'].toString()}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: SizedBox(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text.rich(
                                        TextSpan(
                                            text: '아이템 레벨  ',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14.sp,
                                            ),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text:
                                                    '${character['ItemAvgLevel']}',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              )
                                            ]),
                                      ),
                                      Text.rich(
                                        TextSpan(
                                            text: '서버  ',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12.sp,
                                            ),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text:
                                                    '${character['ServerName']}',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              )
                                            ]),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            character['CharacterName'],
                                            style: TextStyle(
                                              color: character['uid'] == userUID
                                                  ? Colors.amber
                                                  : Colors.white,
                                              fontSize: 18.sp,
                                            ),
                                          ),
                                          SizedBox(width: 4.w),
                                          Icon(
                                            character['credential']
                                                ? CustomIcon.check
                                                : CustomIcon.checkEmpty,
                                            size: 18.sp,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (ctx, idx) {
                      return SizedBox(height: (idx + 1) % 4 != 0 ? 6.h : 12.h);
                    },
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 4.h),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('RegisteredPost')
                  .doc('FindPages')
                  .collection('RaidForTodayPost')
                  .doc(address)
                  .collection('JoinCharacter')
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                List<DocumentSnapshot> joinCharacters =
                    snapshot.data?.docs ?? [];
                List<String> joinUID = [];
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 21.h),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 21, 24, 29),
                      borderRadius: BorderRadius.circular(8.sp),
                    ),
                    child: Text(
                      '',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                      ),
                    ),
                  );
                }
                for (DocumentSnapshot doc in joinCharacters) {
                  joinUID.add(doc.id);
                }
                if (joinUID.contains(userUID)) {
                  return InkWell(
                    onTap: () async {
                      showDialog(
                          barrierDismissible: true,
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.sp),
                              ),
                              backgroundColor: Colors.white,
                              content: Container(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                child: Text(
                                  '파티 모집 글에서 탈퇴하시겠습니까?\n참가자가 남아 있는 경우 모집글은 삭제되지 않습니다.',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.sp,
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
                                        progress?.show();
                                        await RaidForTodayPostViewModel()
                                            .leaveParty(
                                          address: address,
                                          uid: userUID,
                                        )
                                            .then((_) {
                                          progress?.dismiss();
                                          Future.microtask(() {
                                            Navigator.pop(context);
                                            Navigator.pop(context, true);
                                          });
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
                        '파티에서 나가기',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                        ),
                      ),
                    ),
                  );
                } else {
                  return StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('RegisteredPost')
                        .doc('FindPages')
                        .collection('RaidForTodayPost')
                        .doc(address)
                        .collection('RequestCharacter')
                        .snapshots(),
                    builder: (BuildContext ctx, AsyncSnapshot snst) {
                      List<DocumentSnapshot> requestCharacters =
                          snst.data?.docs ?? [];
                      List<String> requestUID = [];
                      if (snst.connectionState == ConnectionState.waiting) {
                        return Container(
                          padding: EdgeInsets.symmetric(vertical: 21.h),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 21, 24, 29),
                            borderRadius: BorderRadius.circular(8.sp),
                          ),
                          child: Text(
                            '',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                            ),
                          ),
                        );
                      }
                      for (DocumentSnapshot doc in requestCharacters) {
                        requestUID.add(doc.id);
                      }
                      if (requestUID.contains(userUID)) {
                        return InkWell(
                          onTap: () async {
                            progress?.show();
                            await RaidForTodayPostViewModel()
                                .removeRequest(
                              address: address,
                              uid: userUID,
                            )
                                .then((_) {
                              progress?.dismiss();
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
                              '신청 취소',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.sp,
                              ),
                            ),
                          ),
                        );
                      } else {
                        return InkWell(
                          onTap: () async {
                            progress?.show();
                            await MyPageViewModel()
                                .getUserInfo(userUID)
                                .then((value) {
                              Future.microtask(() async {
                                progress?.dismiss();
                                if (value['representCharacter'] != null) {
                                  await MyPageViewModel()
                                      .getUserExpedition(userUID)
                                      .then((expedition) async {
                                    if (expedition.isNotEmpty) {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MyExpedition(
                                              expedition: expedition),
                                        ),
                                      ).then((selectCharacter) async {
                                        if (selectCharacter != null) {
                                          progress?.show();
                                          bool credential = false;
                                          if (value['representCharacter'] ==
                                              value['credentialCharacter']) {
                                            credential = true;
                                          }
                                          int myLevel = double.parse(
                                                  selectCharacter[
                                                          'ItemMaxLevel']
                                                      .replaceAll(',', ''))
                                              .toInt();
                                          selectCharacter.addAll({
                                            'uid': userUID,
                                            'credential': credential,
                                          });
                                          if (myLevel >=
                                              lostarkInfo().raidLevel[raid]) {
                                            await RaidForTodayPostViewModel()
                                                .joinRequest(
                                              address: address,
                                              uid: userUID,
                                              data: selectCharacter,
                                            )
                                                .then((_) {
                                              progress?.dismiss();
                                            });
                                          } else {
                                            progress?.dismiss();
                                            showToast(
                                                '선택하신 캐릭터의 레벨이\n레이드 입장 레벨보다 낮습니다.');
                                          }
                                        }
                                      });
                                    } else {
                                      showToast(
                                          '원정대 정보를 확인 할 수 없습니다.\n[내 정보] - [내 원정대 등록하기]');
                                    }
                                  });
                                } else {
                                  showToast(
                                      '내 원정대를 등록해주세요\n[내 정보] - [내 원정대 등록하기]');
                                }
                              });
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
                              '참가 신청',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.sp,
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class RequestUser extends StatelessWidget {
  final String address;
  final progress;
  const RequestUser({
    super.key,
    required this.address,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: StreamBuilder(
        initialData: const [],
        stream: FirebaseFirestore.instance
            .collection('RegisteredPost')
            .doc('FindPages')
            .collection('RaidForTodayPost')
            .doc(address)
            .collection('RequestCharacter')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox();
          }
          List<DocumentSnapshot> requestCharacterList =
              snapshot.data!.docs ?? [];
          return ListView.separated(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 10.h),
            itemCount: requestCharacterList.length,
            itemBuilder: (BuildContext ctx, int idx) {
              Map<String, dynamic> character =
                  requestCharacterList[idx].data() as Map<String, dynamic>;
              return InkWell(
                onTap: () {
                  //캐릭터 페이지 or 원정대 페이지
                  showDialog(
                    barrierDismissible: true,
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.sp),
                        ),
                        backgroundColor: Colors.white,
                        alignment: Alignment.center,
                        content: Container(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                onTap: () async {
                                  progress?.show();
                                  await SearchUserPageViewModel()
                                      .searchUser(
                                          userName: character['CharacterName'])
                                      .then((result) {
                                    progress?.dismiss();
                                    Navigator.pop(context);
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
                                                '${character['CharacterName']}\n캐릭터 정보가 없습니다.');
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
                                  width: double.infinity,
                                  height: 100.h,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 21, 24, 29),
                                    borderRadius: BorderRadius.circular(8.sp),
                                  ),
                                  child: Text(
                                    '캐릭터 정보',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.sp,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (conetxt) => Material(
                                        child: ProgressHUD(
                                          child: MyPage(
                                            uid: character['uid'],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 100.h,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 21, 24, 29),
                                    borderRadius: BorderRadius.circular(8.sp),
                                  ),
                                  child: Text(
                                    '원정대 정보',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 8.h),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 21, 24, 29),
                    borderRadius: BorderRadius.circular(8.sp),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            lostarkInfo()
                                .classIcon[character['CharacterClassName']],
                            color: Colors.white,
                            size: 34.sp,
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            'Lv.${character['CharacterLevel'].toString()}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: SizedBox(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text.rich(
                                TextSpan(
                                    text: '아이템 레벨  ',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14.sp,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: '${character['ItemAvgLevel']}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      )
                                    ]),
                              ),
                              Text.rich(
                                TextSpan(
                                    text: '서버  ',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12.sp,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: '${character['ServerName']}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      )
                                    ]),
                              ),
                              Row(
                                children: [
                                  ConstrainedBox(
                                    constraints:
                                        BoxConstraints(maxWidth: 140.w),
                                    child: Text(
                                      character['CharacterName'],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.sp,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(width: 4.w),
                                  Icon(
                                    character['credential']
                                        ? CustomIcon.check
                                        : CustomIcon.checkEmpty,
                                    size: 18.sp,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      IconButton(
                        onPressed: () async {
                          progress?.show();
                          await RaidForTodayPostViewModel()
                              .acceptRequest(
                            address: address,
                            character: requestCharacterList[idx],
                          )
                              .then((result) async {
                            if (result) {
                              await RaidForTodayPostViewModel()
                                  .removeRequest(
                                address: address,
                                uid: character['uid'],
                              )
                                  .then((_) {
                                progress?.dismiss();
                              });
                            } else {
                              progress?.dismiss();
                              showToast('참가자가 가득 차\n더 이상 수락 할 수 없습니다.');
                            }
                          });
                        },
                        icon: Icon(
                          Icons.check,
                          color: Colors.green,
                          size: 24.sp,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          await RaidForTodayPostViewModel()
                              .removeRequest(
                            address: address,
                            uid: character['uid'],
                          )
                              .then((_) {
                            progress?.dismiss();
                          });
                        },
                        icon: Icon(
                          Icons.close,
                          color: Colors.red,
                          size: 24.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (ctx, idx) {
              return SizedBox(height: (idx + 1) % 4 != 0 ? 6.h : 12.h);
            },
          );
        },
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
          future:
              RaidForTodayPostViewModel().getPostData(address: widget.address),
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
            DateTime startTime = post['startTime'].toDate();
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
                    DateTime now = DateTime.now();
                    if (now.isBefore(startTime)) {
                      if (postTime
                          .isBefore(now.subtract(const Duration(minutes: 1)))) {
                        widget.progress?.show();
                        await RaidForTodayPostViewModel()
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
                    } else {
                      showToast('레이드의 시작 시간이 지나서\n더 이상 끌어올릴 수 없습니다.');
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
