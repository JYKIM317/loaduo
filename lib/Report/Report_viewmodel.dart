import 'Report_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ReportViewModel {
  Future<void> reportPost({
    required String postType,
    required String uid,
    required String address,
    required String reportDetail,
  }) async {
    String? reporter = FirebaseAuth.instance.currentUser!.uid;
    DateTime reportTime = DateTime.now();
    address = address.replaceAll(RegExp(r'\/'), '_');
    print('this is replaceAll method after $address');

    String reportDay =
        '${reportTime.year}.${reportTime.month.toString().padLeft(2, '0')}.${reportTime.day.toString().padLeft(2, '0')}';
    String reportId = 'report_${uid}_${address}_${reportTime.toString()}';

    Map<String, dynamic> reportData = {
      'reporter': reporter,
      'suspect': uid,
      'reportTime': reportTime,
      'reportDetail': reportDetail,
      'postAddress': address,
    };

    await ReportModel().setReport(
      reportId: reportId,
      reportDay: reportDay,
      postType: postType,
      reportData: reportData,
    );
  }
}
