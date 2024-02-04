import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:loaduo/ShowToastMsg.dart';
import 'package:loaduo/ViewPage/InitialDataPages/ApiData/ApiDataPage_view.dart';
import 'package:loaduo/ViewPage/MyPage/AddMyCharacter/AddMyCharacter_viewmodel.dart';
import 'AddMyCharacter_provider.dart';

class AddMyCharacter extends ConsumerStatefulWidget {
  const AddMyCharacter({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddMyCharacterState();
}

class _AddMyCharacterState extends ConsumerState<AddMyCharacter> {
  TextEditingController searchController = TextEditingController();
  Map<String, dynamic> searchAccount = {};

  @override
  Widget build(BuildContext context) {
    final progress = ProgressHUD.of(context);
    final searchUserString = ref.watch(searchMyCharString);
    bool searchInit = searchUserString == searchController.text;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
          centerTitle: false,
          titleSpacing: 0,
          title: Text(
            '내 캐릭터 찾기',
            style: TextStyle(
              fontSize: 24.sp,
              color: Colors.black,
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8.sp),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: Colors.deepOrange[400],
                      size: 32.sp,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: TextField(
                        maxLines: 1,
                        minLines: 1,
                        maxLength: 12,
                        controller: searchController,
                        onChanged: (value) {
                          ref.read(searchMyCharString.notifier).update(value);
                        },
                        onSubmitted: (value) async {
                          progress?.show();
                          await AddMyCharacterViewModel()
                              .searchUser(userName: value)
                              .then((result) {
                            Future.microtask(() {
                              progress?.dismiss();

                              if (result != null) {
                                switch (result['statusCode']) {
                                  case 200:
                                    //요청 성공
                                    if (result['body'] != null) {
                                      Future.microtask(() {
                                        searchAccount = result['body'];
                                        setState(() {});
                                      });
                                    } else {
                                      searchAccount.clear();
                                      showToast('$value\n캐릭터 정보가 없습니다.');
                                    }
                                    break;
                                  case 401:
                                    showToast('API Key가 정상적이지 않습니다.');
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ApiDataPage(),
                                      ),
                                    );
                                    break;
                                  case 429:
                                    //API 요청 횟수 제한
                                    showToast('잠시 후 다시 시도해주세요');
                                    break;
                                  case 503:
                                    //API 서비스 점검
                                    showToast('로스트아크 API 서비스가 점검중에 있습니다.');
                                    break;
                                  default:
                                    showToast('오류가 발생했습니다.');
                                    break;
                                }
                              }
                            });
                          });
                        },
                        decoration: InputDecoration(
                          hintText: '닉네임을 입력해주세요',
                          border: InputBorder.none,
                          counterText: '',
                          suffix: Text(
                            '${searchInit ? searchUserString.length : '0'} / 12',
                            style: TextStyle(
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.grey[300],
              thickness: 2.h,
              height: 40.h,
            ),
            if (searchAccount.isNotEmpty)
              Expanded(
                child: SizedBox(
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    physics: const ClampingScrollPhysics(),
                    itemCount: searchAccount.length,
                    itemBuilder: (BuildContext ctx, int idx) {
                      final String server = searchAccount.keys.toList()[idx];
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  server,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 24.sp,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    await AddMyCharacterViewModel()
                                        .addMyExpedition(
                                      serverName: server,
                                      userName: searchAccount[server][0]
                                          ['CharacterName'],
                                    )
                                        .then((_) {
                                      Future.microtask(() {
                                        Navigator.pop(context, true);
                                      });
                                    });
                                  },
                                  icon: Container(
                                    padding:
                                        EdgeInsets.fromLTRB(6.w, 6.h, 6.w, 6.h),
                                    decoration: BoxDecoration(
                                      color: Colors.deepOrange[400],
                                      borderRadius: BorderRadius.circular(8.sp),
                                    ),
                                    child: Text(
                                      '등록하기',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Divider(
                              color: Colors.grey[300],
                              thickness: 2.h,
                              height: 40.h,
                            ),
                            SizedBox(
                              child: ListView.separated(
                                shrinkWrap: true,
                                physics: const ClampingScrollPhysics(),
                                itemCount: searchAccount[server].length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    padding: EdgeInsets.fromLTRB(
                                        16.w, 14.h, 16.w, 14.h),
                                    decoration: BoxDecoration(
                                      color:
                                          const Color.fromARGB(255, 21, 24, 29),
                                      borderRadius: BorderRadius.circular(8.sp),
                                    ),
                                    child: Text.rich(
                                      TextSpan(
                                          text: searchAccount[server][index]
                                              ['CharacterName'],
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.sp,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text:
                                                  ' ${searchAccount[server][index]['ItemAvgLevel']}',
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
                                                  '${searchAccount[server][index]['CharacterClassName']}',
                                            ),
                                            TextSpan(
                                              text: '  캐릭터 레벨 ',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14.sp,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  '${searchAccount[server][index]['CharacterLevel']}',
                                            ),
                                          ]),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(height: 10.h);
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (ctx, idx) {
                      return Container(
                        height: 20.h,
                        margin: EdgeInsets.symmetric(vertical: 20.h),
                        color: Colors.grey[200],
                      );
                    },
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
