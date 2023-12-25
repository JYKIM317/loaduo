import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:loaduo/ViewPage/InitialDataPages/ApiData/ApiDataPage_view.dart';
import 'package:loaduo/ViewPage/SearchUserPage/SearchUserPage_provider.dart';
import 'package:loaduo/ViewPage/SearchUserPage/SearchUserPage_viewmodel.dart';
import 'package:loaduo/ShowToastMsg.dart';

class SearchUserPage extends ConsumerStatefulWidget {
  const SearchUserPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchUserPageState();
}

class _SearchUserPageState extends ConsumerState<SearchUserPage> {
  TextEditingController searchUserController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final searchUserString = ref.watch(searchString);
    bool searchInit = searchUserString == searchUserController.text;
    return Padding(
      padding: EdgeInsets.only(top: 44.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.only(left: 16.w),
            child: Text(
              '검색',
              style: TextStyle(
                fontSize: 24.sp,
                color: Colors.black,
              ),
            ),
          ),
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
                      controller: searchUserController,
                      onChanged: (value) {
                        ref.read(searchString.notifier).update(value);
                      },
                      onSubmitted: (value) async {
                        await SearchUserPageViewModel()
                            .searchUser(userName: value)
                            .then((result) {
                          Future.microtask(() {
                            setState(() {});
                          });
                          if (result != null) {
                            print(result['statusCode']);
                            switch (result['statusCode']) {
                              case 200:
                                //요청 성공
                                if (result['body'] != null) {
                                  //캐릭터 반환 성공
                                  print(result['body'].toString());
                                } else {
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
          Padding(
            padding: EdgeInsets.only(left: 16.w),
            child: Text(
              '최근 검색어',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.sp,
              ),
            ),
          ),
          Expanded(
            child: Container(
                padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 0),
                child: FutureBuilder(
                  future: SearchUserPageViewModel().getSearchHistory(),
                  initialData: const [],
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    List<dynamic> history = snapshot.data;
                    return ListView.separated(
                      physics: const ClampingScrollPhysics(),
                      itemCount: history.length,
                      itemBuilder: (BuildContext ctx, int idx) {
                        return Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                searchUserController.text = history[idx];
                                ref
                                    .read(searchString.notifier)
                                    .update(history[idx]);
                              },
                              child: Text(
                                history[idx],
                                style: TextStyle(
                                  fontSize: 16.sp,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                await SearchUserPageViewModel()
                                    .deleteSearchHistory(idx)
                                    .then((_) {
                                  Future.microtask(() {
                                    setState(() {});
                                  });
                                });
                              },
                              icon: Icon(
                                Icons.close,
                                color: Colors.grey,
                                size: 24.sp,
                              ),
                            )
                          ],
                        );
                      },
                      separatorBuilder: (ctx, idx) {
                        return const SizedBox(height: 0);
                      },
                    );
                  },
                )),
          )
        ],
      ),
    );
  }
}
