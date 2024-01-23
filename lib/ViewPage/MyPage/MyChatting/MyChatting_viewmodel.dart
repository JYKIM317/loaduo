import 'MyChatting_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class MyChattingViewModel {
  Future<List<String>> getMyChatAddressList() async {
    List<String> chatAddressList = [];
    await MyChattingModel().getMyChattingData().then((querySnapshot) async {
      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        String chatAddress = documentSnapshot.id.replaceAll(' ', '/');
        final conversation =
            await FirebaseDatabase.instance.ref(chatAddress).get();
        if (conversation.exists) {
          chatAddressList.add(chatAddress);
        } else {
          await MyChattingModel()
              .deleteChattingData(docName: documentSnapshot.id);
        }
      }
    });

    return chatAddressList;
  }
}
