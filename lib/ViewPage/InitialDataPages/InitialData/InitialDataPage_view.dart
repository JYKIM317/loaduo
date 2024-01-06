import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:loaduo/ViewPage/InitialDataPages/InitialData/InitialDataPage_provider.dart';
import 'package:loaduo/main.dart';
import 'InitialDataPage_widgets.dart';
import 'InitialDataPage_viewmodel.dart';

class InitialDataPage extends ConsumerWidget {
  const InitialDataPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageIndex = ref.watch(initialDataIndex);
    final bossState = ref.watch(bossraid);
    final adventureState = ref.watch(adventure);
    final homeworkState = ref.watch(homework);
    final mood = ref.watch(yourmood);
    final distribute = ref.watch(yourdistribute);
    final skill = ref.watch(yourskill);
    final weekday = ref.watch(weekdayPlaytime);
    final weekend = ref.watch(weekendPlaytime);

    Future<void> moveIndex() async {
      switch (pageIndex) {
        case 0:
          if (bossState) {
            ref.read(initialDataIndex.notifier).page1();
          } else {
            ref.read(initialDataIndex.notifier).page2();
          }
          await InitialDataViewModel().concernlogic(
            raid: bossState,
            adventure: adventureState,
            homework: homeworkState,
          );
          break;
        case 1:
          ref.read(initialDataIndex.notifier).page2();
          await InitialDataViewModel().raidstyle(
            mood: mood,
            distribute: distribute,
            skill: skill,
          );
          break;
        case 2:
          ref.read(initialDataExist.notifier).existTrue();
          await InitialDataViewModel().playtime(
            weekday: weekday,
            weekend: weekend,
          );
          Future.microtask(() {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const MyApp()),
                (route) => false);
          });
          break;
      }
    }

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(16.w, 44.h, 16.w, 34.h),
        child: Column(children: [
          Expanded(child: [Purpose(), PlayStyle(), PlayTime()][pageIndex]),
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () async {
                    await moveIndex();
                  },
                  icon: Container(
                    width: double.infinity,
                    height: 70.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.deepOrange[400],
                      borderRadius: BorderRadius.circular(8.sp),
                    ),
                    child: Text(
                      '확인',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    await moveIndex();
                  },
                  child: Text(
                    '나중에',
                    style: TextStyle(
                      color: Colors.deepOrange[400],
                      fontSize: 18.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
