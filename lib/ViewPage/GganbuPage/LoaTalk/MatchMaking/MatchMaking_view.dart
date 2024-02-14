import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loaduo/ViewPage/GganbuPage/LoaTalk/AnonymousChatting/AnonymousChatting_view.dart';
import 'MatchMaking_model.dart';

class MatchMakingPage extends ConsumerWidget {
  const MatchMakingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String? userUID = FirebaseAuth.instance.currentUser!.uid;
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.fromLTRB(16.w, 44.h, 16.w, 34.h),
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Users')
                  .doc(userUID)
                  .collection('AnonymousChat')
                  .doc('address')
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                Map<String, dynamic>? anonymousAddress =
                    snapshot.data?.data() as Map<String, dynamic>?;
                if (anonymousAddress != null) {
                  //채팅 개설되어있는지 확인 후 페이지 이동하는 로직
                  MatchMakingModel()
                      .existAnonymousChatting(
                          uid: userUID,
                          address: anonymousAddress['chatAddress'])
                      .then((response) {
                    if (response['exist']) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AnonymousChattingPage(
                            info: response['info'],
                            otherPerson: response['otherPerson'],
                            address:
                                '${anonymousAddress['chatAddress']}/Messages',
                          ),
                        ),
                      );
                    } else {
                      MatchMakingModel()
                          .initializeAnonymousChatting(uid: userUID);
                      Navigator.pop(context);
                    }
                  });
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SizedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const CircularProgressIndicator(
                                color: Colors.black),
                            SizedBox(height: 10.h),
                            Text(
                              '매칭 중..',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () async {
                            //MatchMaking Standby 삭제 후
                            await MatchMakingModel()
                                .removeStandbyData(uid: userUID);
                            Future.microtask(() => Navigator.pop(context));
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 10.h),
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(8.sp),
                            ),
                            child: Text(
                              '매칭 취소',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
