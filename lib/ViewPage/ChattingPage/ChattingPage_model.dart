import 'package:firebase_database/firebase_database.dart';

class ChattingPageModel {
  Future<void> saveMessageData({
    required String address,
    required String messageId,
    required Map<String, dynamic> message,
  }) async {
    final chatAddress = FirebaseDatabase.instance.ref('$address/$messageId');
    await chatAddress.set(message);
  }
}
