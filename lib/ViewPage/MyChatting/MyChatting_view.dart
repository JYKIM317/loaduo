import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loaduo/CustomIcon.dart';
import 'MyChatting_viewmodel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loaduo/ViewPage/ChattingPage/ChattingPage_view.dart';

class MyChatting extends StatefulWidget {
  const MyChatting({super.key});

  @override
  State<MyChatting> createState() => _MyChattingState();
}

class _MyChattingState extends State<MyChatting> {
  String? userUID = FirebaseAuth.instance.currentUser!.uid;
  int chatIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(top: 44.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.only(left: 16.w),
                child: Text(
                  '활성화 된 채팅',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24.sp,
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  future: MyChattingViewModel().getMyChatAddressList(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    List<String> chatAddressList = snapshot.data ?? [];
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      padding: EdgeInsets.fromLTRB(16.w, 34.h, 16.w, 44.h),
                      itemCount: chatAddressList.length,
                      itemBuilder: (BuildContext ctx, int idx) {
                        return StreamBuilder(
                          stream: FirebaseDatabase.instance
                              .ref(chatAddressList[idx])
                              .onValue,
                          builder:
                              (BuildContext context2, AsyncSnapshot snapshot2) {
                            Map<dynamic, dynamic>? chat = snapshot2
                                .data?.snapshot.value as Map<dynamic, dynamic>?;
                            DateTime? lastTextDate;
                            String? title, subtitle;
                            String lastTextTime = '채팅 내역이 없습니다.';
                            late String? uid;
                            if (chat == null) {
                              return SizedBox(
                                child: Column(
                                  children: [
                                    SizedBox(height: 18.sp),
                                    SizedBox(height: 60.h),
                                  ],
                                ),
                              );
                            } else {
                              if (chat['raid'] != null) {
                                title = chat['raid']['title'];
                                subtitle = chat['raid']['subtitle'];
                                uid = userUID;
                              } else {
                                uid = chat['info']
                                    .keys
                                    .where((element) => element != userUID)
                                    .first;
                              }
                            }
                            List<MapEntry<dynamic, dynamic>>? chatToList;
                            if (chat['Messages'] != null) {
                              chatToList = chat['Messages'].entries.toList();
                              chatToList!.sort(
                                (a, b) {
                                  DateTime timeA =
                                      DateTime.parse(a.value['sendTime']);
                                  DateTime timeB =
                                      DateTime.parse(b.value['sendTime']);
                                  return timeA.compareTo(timeB);
                                },
                              );
                              lastTextDate = DateTime.parse(
                                  chatToList.last.value['sendTime']);
                              DateTime now = DateTime.now();
                              final difference = now.difference(lastTextDate);
                              if (difference.inDays >= 1) {
                                lastTextTime =
                                    '${lastTextDate.month}월 ${lastTextDate.day}일';
                              } else if (difference.inDays == 0) {
                                lastTextTime =
                                    '${lastTextDate.hour >= 12 ? '오후' : '오전'} ${lastTextDate.hour > 12 ? lastTextDate.hour - 12 : lastTextDate.hour}시 ${lastTextDate.minute.toString().padLeft(2, '0')}분';
                              }
                            }
                            String address = '${chatAddressList[idx]}/Messages';
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChattingPage(
                                      info: chat['info'][userUID],
                                      otherPersonInfo: chat['info'][uid],
                                      address: address,
                                      members: chat['info'].keys.toList(),
                                      raidInfo: title != null
                                          ? {
                                              'title': title,
                                              'subtitle': subtitle
                                            }
                                          : null,
                                    ),
                                    settings: const RouteSettings(
                                        name: 'ChattingPage'),
                                  ),
                                );
                              },
                              child: Container(
                                width: double.infinity,
                                padding:
                                    EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 8.h),
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 21, 24, 29),
                                  borderRadius: BorderRadius.circular(8.sp),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text.rich(
                                          TextSpan(
                                            text: title ??
                                                chat['info'][uid]['name'],
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.sp,
                                            ),
                                            children: <TextSpan>[
                                              const TextSpan(text: ' '),
                                              TextSpan(
                                                text: subtitle ??
                                                    chat['info'][uid]['server'],
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12.sp,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 4.w),
                                        if (title == null)
                                          Icon(
                                            chat['info'][uid]['credential']
                                                ? CustomIcon.check
                                                : CustomIcon.checkEmpty,
                                            size: 21.sp,
                                            color: Colors.white,
                                          ),
                                      ],
                                    ),
                                    SizedBox(height: 4.h),
                                    SizedBox(
                                      height: 60.h,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: SizedBox(
                                              child: Text(
                                                chat['Messages'] != null
                                                    ? chatToList!
                                                        .last.value['text']
                                                    : '',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18.sp,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: double.infinity,
                                            alignment: Alignment.bottomCenter,
                                            child: Text(
                                              lastTextTime,
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      separatorBuilder: (ctx, idx) {
                        return SizedBox(height: 10.h);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
