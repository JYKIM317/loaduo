import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:loaduo/ViewPage/InitialDataPages/InitialData/InitialDataPage_view.dart';
import 'package:loaduo/main.dart';

import 'package:loaduo/ShowToastMsg.dart';
import 'ApiDataPage_viewmodel.dart';

class ApiDataPage extends ConsumerStatefulWidget {
  const ApiDataPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ApiDataPageState();
}

class _ApiDataPageState extends ConsumerState<ApiDataPage> {
  TextEditingController apiTextController = TextEditingController();
  String? apiText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          padding: EdgeInsets.fromLTRB(16.w, 44.h, 16.w, 34.h),
          child: Column(
            children: [
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'API Key가 필요해요!',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24.sp,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      IconButton(
                        onPressed: () async {
                          await ApiDataViewModel().launchAPIUrl();
                        },
                        icon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'API Key 발급하러 가기',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                                fontSize: 18.sp,
                              ),
                            ),
                            Icon(
                              Icons.golf_course,
                              color: Colors.black.withOpacity(0.6),
                              size: 28.sp,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),
                      TextField(
                        controller: apiTextController,
                        onChanged: (value) {
                          apiText = value;
                        },
                        maxLines: 1,
                        minLines: 1,
                        decoration: const InputDecoration(
                          hintText: '이곳에 복사해주세요',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () async {
                        if (apiText != null) {
                          ref.read(apikey.notifier).update(apiText!);
                          await ApiDataViewModel().saveAPI(apiText!);
                        } else {
                          showToast('API Key를 입력해주세요');
                        }
                      },
                      icon: Container(
                        width: double.infinity,
                        height: 80.h,
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
                      onPressed: () {
                        ref.read(apikey.notifier).update('nulll');
                        final myInitialDataExist = ref.watch(initialDataExist);
                        myInitialDataExist ? RoutePage() : InitialDataPage();
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
            ],
          ),
        ),
      ),
    );
  }
}
