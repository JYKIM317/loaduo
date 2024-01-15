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

class JoinUser extends StatelessWidget {
  final String address, leader;
  final progress;
  const JoinUser({
    super.key,
    required this.address,
    required this.leader,
    required this.progress,
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
                      return Container(
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
                                          selectCharacter.addAll({
                                            'uid': userUID,
                                            'credential': credential,
                                          });
                                          await RaidForTodayPostViewModel()
                                              .joinRequest(
                                            address: address,
                                            uid: userUID,
                                            data: selectCharacter,
                                          )
                                              .then((_) {
                                            progress?.dismiss();
                                          });
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
              final character = requestCharacterList[idx];
              return Container(
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
                              .classIcon[character.get('CharacterClassName')],
                          color: Colors.white,
                          size: 34.sp,
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          'Lv.${character.get('CharacterLevel').toString()}',
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
                                      text: '${character.get('ItemAvgLevel')}',
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
                                      text: '${character.get('ServerName')}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    )
                                  ]),
                            ),
                            Row(
                              children: [
                                Text(
                                  character.get('CharacterName'),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.sp,
                                  ),
                                ),
                                SizedBox(width: 4.w),
                                Icon(
                                  character.get('credential')
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

class PostSetting extends StatelessWidget {
  final String address;
  final progress;
  const PostSetting({
    super.key,
    required this.address,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
    );
  }
}
