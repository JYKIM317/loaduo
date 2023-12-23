import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class MyPage extends ConsumerStatefulWidget {
  final String uid;
  const MyPage({super.key, required this.uid});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyPageState();
}

class _MyPageState extends ConsumerState<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 44.h, 16.w, 0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Text.rich(
                TextSpan(
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                    ),
                    text: '저는 ',
                    children: <TextSpan>[
                      TextSpan(
                        style: TextStyle(color: Colors.deepOrange[400]),
                        text: '레이드, 일일 숙제', //concern
                      ),
                      const TextSpan(
                        text: ' 깐부를 찾고 있어요\n저는 레이드를 ',
                      ),
                      TextSpan(
                        style: TextStyle(color: Colors.deepOrange[400]),
                        text: '몰아서 빼요', //raidDistribute
                      ),
                      const TextSpan(
                        text: '\n레이드는 주로 ',
                      ),
                      TextSpan(
                        style: TextStyle(color: Colors.deepOrange[400]),
                        text: '숙련', //raidSkill
                      ),
                      const TextSpan(
                        text: ' 파티를 가는 편이고\n레이드를 돌 때는 ',
                      ),
                      TextSpan(
                        style: TextStyle(color: Colors.deepOrange[400]),
                        text: '예민하지 않아요', //raidMood
                      ),
                      const TextSpan(
                        text: '\n평일은 ',
                      ),
                      TextSpan(
                        style: TextStyle(color: Colors.deepOrange[400]),
                        text: '20', //weekdayPlaytime
                      ),
                      const TextSpan(
                        text: '시 주말은 ',
                      ),
                      TextSpan(
                        style: TextStyle(color: Colors.deepOrange[400]),
                        text: '14', //weekendPlaytime
                      ),
                      const TextSpan(
                        text: '시에\n접속해있는 편이에요',
                      ),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
