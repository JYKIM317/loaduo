import 'Report_viewmodel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:loaduo/ShowToastMsg.dart';

class Report extends StatefulWidget {
  final String postType, uid, address;

  const Report({
    super.key,
    required this.postType,
    required this.uid,
    required this.address,
  });

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  TextEditingController detailController = TextEditingController();
  String detail = '';
  String? userUID = FirebaseAuth.instance.currentUser!.uid;
  late String postType, uid, address;
  @override
  void initState() {
    postType = widget.postType;
    uid = widget.uid;
    address = widget.address;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final progress = ProgressHUD.of(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(16.w, 70.h, 16.w, 44.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '신고 내용',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 21.sp,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 10.h,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.sp),
                          border: Border.all(
                            color: Colors.deepOrange[400]!,
                            width: 2.sp,
                          ),
                        ),
                        child: TextField(
                          controller: detailController,
                          minLines: 5,
                          maxLines: null,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            detail = value;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 34.h),
                child: InkWell(
                  onTap: () async {
                    if (detail != '' && detail.trim() != '') {
                      progress?.show();
                      await ReportViewModel()
                          .reportPost(
                        postType: postType,
                        uid: uid,
                        address: address,
                        reportDetail: detail,
                      )
                          .then((_) {
                        progress?.dismiss();
                        showToast('신고가 접수되었습니다\n깨끗한 서비스에 힘써주셔서 감사합니다.');
                        Navigator.pop(context);
                      });
                    } else {
                      showToast('신고 내용을 입력해주세요');
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(10.w, 12.h, 10.w, 12.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.sp),
                      color: Colors.deepOrange[400],
                    ),
                    child: Text(
                      '신고하기',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.sp,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
