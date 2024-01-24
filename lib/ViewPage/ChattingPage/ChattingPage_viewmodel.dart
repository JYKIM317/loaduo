import 'ChattingPage_model.dart';

class ChattingPageViewModel {
  Future<void> sendMessage({
    required String address,
    required String name,
    required String server,
    required String uid,
    required String text,
    required DateTime sendTime,
  }) async {
    String messageId =
        'message_${sendTime.toString().replaceAll(RegExp(r'\.|\#|\$|\[|\]|\/\/'), '_')}_$uid';
    Map<String, dynamic> messageData = {
      'name': name,
      'server': server,
      'uid': uid,
      'text': text,
      'sendTime': sendTime.toString(),
    };
    await ChattingPageModel().saveMessageData(
      address: address,
      messageId: messageId,
      message: messageData,
    );
  }
}
