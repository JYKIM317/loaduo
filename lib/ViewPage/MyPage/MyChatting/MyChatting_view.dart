import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loaduo/CustomIcon.dart';
import 'MyChatting_viewmodel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyChatting extends StatefulWidget {
  const MyChatting({super.key});

  @override
  State<MyChatting> createState() => _MyChattingState();
}

class _MyChattingState extends State<MyChatting> {
  String? userUID = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 74.h),
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
            Divider(
              color: Colors.grey[300],
              thickness: 2.h,
              height: 40.h,
            ),
            Expanded(
              child: FutureBuilder(
                future: MyChattingViewModel().getMyChatAddressList(),
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
                  List<String> chatAddressList = snapshot.data;
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    padding: EdgeInsets.fromLTRB(16.w, 34.h, 16.w, 44.h),
                    itemCount: chatAddressList.length,
                    itemBuilder: (BuildContext ctx, int idx) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SizedBox();
                      }
                      return Container(
                        width: double.infinity,
                        padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 8.h),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 21, 24, 29),
                          borderRadius: BorderRadius.circular(8.sp),
                        ),
                        child: StreamBuilder(
                          stream: FirebaseDatabase.instance
                              .ref(chatAddressList[idx])
                              .onValue,
                          builder:
                              (BuildContext context2, AsyncSnapshot snapshot2) {
                            Map<dynamic, dynamic>? chat = snapshot2
                                .data?.snapshot.value as Map<dynamic, dynamic>?;
                            DateTime? lastTextDate;
                            String lastTextTime = '채팅 내역이 없습니다.';
                            late String? uid;
                            if (chat == null) {
                              return const SizedBox();
                            } else {
                              uid = chat['info']
                                  .keys
                                  .where((element) => element != userUID)
                                  .first;
                            }
                            if (chat['Messages'] != null) {
                              lastTextDate = DateTime.parse(
                                  chat['Messages'].values.last['sendTime']);
                              DateTime now = DateTime.now();
                              final difference = lastTextDate.difference(now);
                              if (difference.inDays >= 1) {
                                lastTextTime =
                                    '${lastTextDate.month}월 ${lastTextDate.day}일';
                              } else if (difference.inDays == 0) {
                                lastTextTime =
                                    '${lastTextDate.hour.toString().padLeft(2, '0')}:${lastTextDate.minute.toString().padLeft(2, '0')}';
                              }
                            }
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text.rich(
                                      TextSpan(
                                        text: chat['info'][uid]['name'],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.sp,
                                        ),
                                        children: <TextSpan>[
                                          const TextSpan(text: ' '),
                                          TextSpan(
                                            text: chat['info'][uid]['server'],
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 4.w),
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
                                                ? chat['Messages']
                                                    .values
                                                    .last['text']
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
                            );
                          },
                        ),
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
    );
  }
}
