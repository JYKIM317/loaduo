import 'AnonymousChatting_model.dart';

class AnonymousChattingViewModel {
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
    await AnonymousChattingModel().saveMessageData(
      address: address,
      messageId: messageId,
      message: messageData,
    );
    String updateTimeAddress = address.replaceAll('/Messages', '');
    await AnonymousChattingModel().updateMessageTime(
      address: updateTimeAddress,
      lastMessageTime: sendTime.toString(),
    );
  }

  Future<bool> addMyChat({
    required String me,
    required String otherPerson,
    required String address,
  }) async {
    late bool result;
    await AnonymousChattingModel()
        .getThisChatData(
      address: address.replaceAll('/Messages', ''),
    )
        .then((data) async {
      if (data != null) {
        result = await AnonymousChattingModel().moveThisChatData(
          me: me,
          otherPerson: otherPerson,
          data: data,
        );
        await AnonymousChattingModel().addChatAddressData(
          me: me,
          otherPerson: otherPerson,
        );
      } else {
        result = false;
      }
    });

    return result;
  }
}
