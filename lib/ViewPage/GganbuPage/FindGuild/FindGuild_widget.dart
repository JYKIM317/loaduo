import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:loaduo/ShowToastMsg.dart';
import 'package:loaduo/ViewPage/GganbuPage/FindGuild/FindGuild_provider.dart';
import 'package:loaduo/lostark_info.dart';

class ServerDrawer extends ConsumerStatefulWidget {
  final bottomController;
  const ServerDrawer({super.key, required this.bottomController});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ServerDrawerState();
}

class _ServerDrawerState extends ConsumerState<ServerDrawer> {
  @override
  Widget build(BuildContext context) {
    final server = ref.watch(guildServerFilter);
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.only(bottom: 34.h),
              itemCount: lostarkInfo().serverList.length,
              itemBuilder: (BuildContext ctx, int idx) {
                String serverName = lostarkInfo().serverList[idx];
                return TextButton(
                  onPressed: () {
                    if (serverName == '전체') {
                      ref.read(guildServerFilter.notifier).update(null);
                    } else {
                      ref.read(guildServerFilter.notifier).update(serverName);
                    }
                    widget.bottomController.close();
                  },
                  child: Text(
                    serverName,
                    style: TextStyle(
                      color: server == serverName
                          ? Colors.deepOrange[400]
                          : Colors.black,
                      fontSize: 24.sp,
                    ),
                  ),
                );
              },
              separatorBuilder: (ctx, idx) {
                return SizedBox(height: 10.h);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TypeDrawer extends ConsumerStatefulWidget {
  final bottomController;
  const TypeDrawer({super.key, required this.bottomController});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TypeDrawerState();
}

class _TypeDrawerState extends ConsumerState<TypeDrawer> {
  List<String> typeList = ['전체', '자유길드', '친목길드', '혈석길드', 'PvP길드'];
  @override
  Widget build(BuildContext context) {
    final type = ref.watch(guildTypeFilter);
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.only(bottom: 34.h),
              itemCount: typeList.length,
              itemBuilder: (BuildContext ctx, int idx) {
                String typeName = typeList[idx];
                return TextButton(
                  onPressed: () {
                    if (typeName == '전체') {
                      ref.read(guildTypeFilter.notifier).update(null);
                    } else {
                      ref.read(guildTypeFilter.notifier).update(typeName);
                    }
                    widget.bottomController.close();
                  },
                  child: Text(
                    typeName,
                    style: TextStyle(
                      color: type == typeName
                          ? Colors.deepOrange[400]
                          : Colors.black,
                      fontSize: 24.sp,
                    ),
                  ),
                );
              },
              separatorBuilder: (ctx, idx) {
                return SizedBox(height: 10.h);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class LevelDrawer extends ConsumerStatefulWidget {
  final bottomController;
  const LevelDrawer({super.key, required this.bottomController});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LevelDrawerState();
}

class _LevelDrawerState extends ConsumerState<LevelDrawer> {
  TextEditingController levelController = TextEditingController();
  int? inputLevel;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 34.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 140.w,
                child: TextField(
                  controller: levelController,
                  onChanged: (value) {
                    inputLevel = int.parse(value);
                  },
                  maxLines: 1,
                  minLines: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24.sp),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: '아이템 레벨',
                    hintStyle: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              Text(
                '이 가입 가능한 길드',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24.sp,
                ),
              ),
            ],
          )),
          InkWell(
            onTap: () {
              if (inputLevel != null && inputLevel! >= 100) {
                if (inputLevel! >= 0 && inputLevel! <= lostarkInfo().maxLevel) {
                  ref.read(guildLevelFilter.notifier).update(inputLevel);
                  FocusScope.of(context).unfocus();
                  widget.bottomController.close();
                } else {
                  FocusScope.of(context).unfocus();
                  showToast('입력하신 아이템 레벨이 잘못되었습니다');
                }
              } else if (inputLevel == null || inputLevel! < 100) {
                ref.read(guildLevelFilter.notifier).update(null);
                FocusScope.of(context).unfocus();
                showToast('레벨을 입력해주세요');
                widget.bottomController.close();
              }
            },
            child: Container(
              width: double.infinity,
              height: 80.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.sp),
                color: Colors.deepOrange[400],
              ),
              child: Text(
                '필터 적용하기',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
