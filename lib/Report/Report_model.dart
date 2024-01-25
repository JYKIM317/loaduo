import 'package:cloud_firestore/cloud_firestore.dart';

class ReportModel {
  Future<void> setReport({
    required String reportId,
    required String reportDay,
    required String postType,
    required Map<String, dynamic> reportData,
  }) async {
    await FirebaseFirestore.instance
        .collection('Report')
        .doc(reportDay)
        .collection(postType)
        .doc(reportId)
        .set(reportData);
  }
}
