import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class MyExpedition extends StatelessWidget {
  final expedition;
  const MyExpedition({super.key, required this.expedition});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          padding: EdgeInsets.only(top: 84.h, bottom: 34.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '어떤 캐릭터로\n참여하실 건가요?',
                style: TextStyle(
                  color: const Color.fromARGB(255, 21, 24, 29),
                  fontSize: 28.sp,
                ),
              ),
              SizedBox(height: 30.h),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.only(bottom: 10.h),
                itemCount: expedition.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async {
                      Navigator.pop(context, expedition[index]);
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
                                text: ' ${expedition[index]['ItemAvgLevel']}',
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
                                text: '${expedition[index]['CharacterLevel']}',
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
            ],
          ),
        ),
      ),
    );
  }
}
