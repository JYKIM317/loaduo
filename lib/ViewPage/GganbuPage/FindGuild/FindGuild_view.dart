import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:bottom_drawer/bottom_drawer.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loaduo/ViewPage/MyPage/MyPage_viewmodel.dart';
import 'package:loaduo/ShowToastMsg.dart';
import 'package:loaduo/ViewPage/GganbuPage/FindGuild/CreateGuildPost/CreateGuildPost_view.dart';
import 'package:loaduo/ViewPage/GganbuPage/FindGuild/FindGuild_provider.dart';
import 'FindGuild_widget.dart';
import 'package:loaduo/lostark_info.dart';
import 'FindGuild_viewmodel.dart';
import 'GuildPostView/GuildPostView_view.dart';

class FindGuild extends ConsumerStatefulWidget {
  const FindGuild({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FindGuildState();
}

class _FindGuildState extends ConsumerState<FindGuild> {
  BottomDrawerController _bottomDrawerController = BottomDrawerController();

  Widget bottomDrawer(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BottomDrawer(
        controller: _bottomDrawerController,
        header: const SizedBox(height: 0),
        cornerRadius: 16.sp,
        color: Colors.grey[100]!,
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            blurRadius: 1,
          )
        ],
        body: [
          ServerDrawer(bottomController: _bottomDrawerController),
          TypeDrawer(bottomController: _bottomDrawerController),
          LevelDrawer(bottomController: _bottomDrawerController),
        ][ref.watch(guildFilterIndex)], //widget view by filterIndex
        headerHeight: 0,
        drawerHeight: 472.h,
      ),
    );
  }

  int postCount = 30;
  late Future guildLoadData;
  var serverFilter;
  var typeFilter;
  var levelFilter;

  DocumentSnapshot? lastDoc;
  List<Map<String, dynamic>>? docList;
  bool isLoad = false;
  ScrollController scrollController = ScrollController();
  double? lastScrollOffset;
  onScroll() async {
    bool reachMaxExtent =
        scrollController.offset >= scrollController.position.maxScrollExtent;
    bool outOfRange = !scrollController.position.outOfRange &&
        scrollController.position.pixels != 0;
    bool existInitalData = lastDoc != null;

    if (reachMaxExtent && outOfRange && existInitalData && isLoad == false) {
      isLoad = true;
      lastScrollOffset = scrollController.position.maxScrollExtent;

      guildLoadData = FindGuildViewModel().getGuildPostList(
        count: postCount,
        server: serverFilter,
        type: typeFilter,
        level: levelFilter,
        lastDoc: lastDoc,
        initialList: docList,
      );
      Future.delayed(const Duration(milliseconds: 500)).then((_) {
        setState(() {});
      });

      isLoad = false;
    }
  }

  @override
  void initState() {
    guildLoadData = FindGuildViewModel().getGuildPostList(
      count: postCount,
      server: serverFilter,
      type: typeFilter,
      level: levelFilter,
      lastDoc: lastDoc,
    );
    scrollController.addListener(() {
      onScroll();
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progress = ProgressHUD.of(context);
    serverFilter = ref.watch(guildServerFilter);
    typeFilter = ref.watch(guildTypeFilter);
    levelFilter = ref.watch(guildLevelFilter);
    ref.listen(guildServerFilter, (previousState, newState) {
      serverFilter = newState;
      lastDoc = null;
      docList = null;
      guildLoadData = FindGuildViewModel().getGuildPostList(
        count: postCount,
        server: serverFilter,
        type: typeFilter,
        level: levelFilter,
        lastDoc: lastDoc,
      );
    });
    ref.listen(guildTypeFilter, (previousState, newState) {
      typeFilter = newState;
      lastDoc = null;
      docList = null;
      guildLoadData = FindGuildViewModel().getGuildPostList(
        count: postCount,
        server: serverFilter,
        type: typeFilter,
        level: levelFilter,
        lastDoc: lastDoc,
      );
    });
    ref.listen(guildLevelFilter, (previousState, newState) {
      levelFilter = newState;
      lastDoc = null;
      docList = null;
      guildLoadData = FindGuildViewModel().getGuildPostList(
        count: postCount,
        server: serverFilter,
        type: typeFilter,
        level: levelFilter,
        lastDoc: lastDoc,
      );
    });

    return GestureDetector(
      onTap: () => _bottomDrawerController.close(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            String? userUID = FirebaseAuth.instance.currentUser!.uid;
            progress?.show();
            await MyPageViewModel().getUserInfo(userUID).then((value) {
              Future.microtask(() async {
                if (value['representCharacter'] != null) {
                  await MyPageViewModel()
                      .getCharacterData(userName: value['representCharacter'])
                      .then((character) async {
                    progress?.dismiss();
                    if (character!['body'] != null &&
                        character['statusCode'] == 200) {
                      if (character['body']['ArmoryProfile']['GuildName'] !=
                          null) {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => ProgressHUD(
                                  child: CreateGuildPost(
                                    guildName: character['body']
                                        ['ArmoryProfile']['GuildName'],
                                    server: value['representServer'],
                                  ),
                                )),
                          ),
                        ).then((value) {
                          bool create = value ?? false;
                          if (create) {
                            setState(() {
                              lastDoc = null;
                              docList = null;
                              guildLoadData =
                                  FindGuildViewModel().getGuildPostList(
                                count: postCount,
                                server: serverFilter,
                                type: typeFilter,
                                level: levelFilter,
                                lastDoc: lastDoc,
                              );
                            });
                          }
                        });
                      } else {
                        showToast('원정대의 대표 캐릭터가 가입한 길드를 확인할 수 없습니다.');
                      }
                    } else {
                      showToast(
                          '원정대의 대표 캐릭터 정보를 찾을 수 없거나,\n일시적인 오류로 인해 기능을 이용할 수 없습니다.');
                    }
                  });
                } else {
                  showToast('내 원정대를 등록해주세요\n[내 정보] - [내 원정대 등록하기]');
                }
                progress?.dismiss();
              });
            });
          },
          backgroundColor: Colors.deepOrange[400],
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 36.sp,
          ),
        ),
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 16.w, top: 84.h),
                    child: Text(
                      '길드',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 21, 24, 29),
                        fontSize: 36.sp,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    height: 70.h,
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                      ),
                      physics: const ClampingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: [
                        InkWell(
                          onTap: () {
                            _bottomDrawerController.close();
                            ref.read(guildFilterIndex.notifier).update(0);
                            _bottomDrawerController.open();
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 8.h),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.sp),
                              color: serverFilter == null
                                  ? Colors.grey
                                  : Colors.deepOrange[400],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  serverFilter ?? '서버 전체',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                SizedBox(width: 4.w),
                                Icon(
                                  Icons.arrow_drop_down_rounded,
                                  color: Colors.white,
                                  size: 24.sp,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        InkWell(
                          onTap: () {
                            _bottomDrawerController.close();
                            ref.read(guildFilterIndex.notifier).update(1);
                            _bottomDrawerController.open();
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 8.h),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.sp),
                              color: typeFilter == null
                                  ? Colors.grey
                                  : Colors.deepOrange[400],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  typeFilter ?? '길드 유형 전체',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                SizedBox(width: 4.w),
                                Icon(
                                  Icons.arrow_drop_down_rounded,
                                  color: Colors.white,
                                  size: 24.sp,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        InkWell(
                          onTap: () {
                            _bottomDrawerController.close();
                            ref.read(guildFilterIndex.notifier).update(2);
                            _bottomDrawerController.open();
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 8.h),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.sp),
                              color: levelFilter == null
                                  ? Colors.grey
                                  : Colors.deepOrange[400],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  levelFilter == null
                                      ? '레벨 제한 전체'
                                      : levelFilter.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                SizedBox(width: 4.w),
                                Icon(
                                  Icons.arrow_drop_down_rounded,
                                  color: Colors.white,
                                  size: 24.sp,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.grey[300],
                    thickness: 2.h,
                    height: 40.h,
                  ),
                  SizedBox(height: 10.h),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 10.h),
                      physics: const ClampingScrollPhysics(),
                      controller: scrollController,
                      child: FutureBuilder(
                          future: guildLoadData,
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.waiting &&
                                docList == null) {
                              return SizedBox(
                                height: 246.h,
                                child: Center(
                                    child: CircularProgressIndicator(
                                  color: Colors.deepOrange[400],
                                )),
                              );
                            }
                            List<Map<String, dynamic>> postList =
                                snapshot.data['postList'] ?? [];
                            if (snapshot.data['lastDoc'] != null) {
                              lastDoc = snapshot.data['lastDoc'];
                              docList = postList;
                            }
                            return ListView.separated(
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              itemCount: postList.length,
                              itemBuilder: (BuildContext ctx, int idx) {
                                Map<String, dynamic> post = postList[idx];
                                return InkWell(
                                  onTap: () async {
                                    //자세히 보기
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProgressHUD(
                                          child: GuildPostView(
                                            post: post,
                                          ),
                                        ),
                                      ),
                                    ).then((value) {
                                      bool leave = value ?? false;
                                      if (leave) {
                                        setState(() {
                                          lastDoc = null;
                                          docList = null;
                                          guildLoadData = FindGuildViewModel()
                                              .getGuildPostList(
                                            count: postCount,
                                            server: serverFilter,
                                            type: typeFilter,
                                            level: levelFilter,
                                            lastDoc: lastDoc,
                                          );
                                        });
                                      }
                                    });
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 210.h,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.sp),
                                      color:
                                          const Color.fromARGB(255, 21, 24, 29),
                                    ),
                                    padding: EdgeInsets.fromLTRB(
                                        16.w, 20.h, 16.w, 20.h),
                                    child: Stack(
                                      children: [
                                        Opacity(
                                          opacity: 0.2,
                                          child: Transform.translate(
                                            offset: Offset(140.w, 30.h),
                                            child: Transform.scale(
                                              scale: 3,
                                              child: Image.network(
                                                lostarkInfo()
                                                    .networkImage['길드']!,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Container(
                                                      color:
                                                          const Color.fromARGB(
                                                              255, 21, 24, 29));
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              post['guildName'],
                                              style: TextStyle(
                                                color: Colors.deepOrange[400],
                                                fontSize: 24.sp,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                post['detail'],
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18.sp,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text.rich(
                                                  TextSpan(
                                                    text: '#',
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 18.sp,
                                                    ),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text:
                                                            '${post['server']} ',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18.sp,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Text.rich(
                                                  TextSpan(
                                                    text: '#',
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 18.sp,
                                                    ),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text:
                                                            '${post['guildType']} ',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18.sp,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Text.rich(
                                                  TextSpan(
                                                    text: '#',
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 18.sp,
                                                    ),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text: post['level'] != 0
                                                            ? '${post['level']} 이상 '
                                                            : '레벨 제한 없음',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18.sp,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (ctx, idx) {
                                return SizedBox(height: 10.h);
                              },
                            );
                          }),
                    ),
                  ),
                ],
              ),
            ),
            bottomDrawer(context),
          ],
        ),
      ),
    );
  }
}
