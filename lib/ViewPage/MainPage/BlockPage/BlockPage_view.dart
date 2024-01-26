import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loaduo/ViewPage/MainPage/MainPage_view.dart';
import 'BlockPage_model.dart';

class BlockUserPage extends StatefulWidget {
  const BlockUserPage({super.key});

  @override
  State<BlockUserPage> createState() => _BlockUserPageState();
}

class _BlockUserPageState extends State<BlockUserPage> {
  String? userUID = FirebaseAuth.instance.currentUser!.uid;

  Future<void> release() async {
    await BlockPageModel().removeBlockUserData(uid: userUID!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('BlockUsers')
              .doc(userUID)
              .get(),
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
            Map<String, dynamic>? blockData = snapshot.data?.data();
            DateTime releaseDate = blockData!['date'].toDate();
            DateTime now = DateTime.now();
            if (blockData.isEmpty || releaseDate.isBefore(now)) {
              release().then(
                (_) => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainPage(),
                    ),
                    (route) => false),
              );
            }
            return Center(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 44.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '계정이 임시차단 상태입니다.',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 28.sp,
                      ),
                    ),
                    SizedBox(height: 30.h),
                    Text(
                      '사유 : ${blockData['reason'].toString()}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.sp,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      '일시 : ${releaseDate.year}년 ${releaseDate.month}월${releaseDate.day}일 ${releaseDate.hour}시${releaseDate.minute.toString().padLeft(2, '0')}분',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.sp,
                      ),
                    ),
                    SizedBox(height: 30.h),
                    Text(
                      '기타 문의사항은\nloahands.help@gmail.com 으로\n메일 부탁드립니다.',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
