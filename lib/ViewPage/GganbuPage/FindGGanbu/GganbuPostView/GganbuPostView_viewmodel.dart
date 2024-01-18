import 'GganbuPostView_model.dart';

class GganbuPostViewModel {
  Future<Map<String, dynamic>> getPostData({required String address}) async {
    Map<String, dynamic> postData = {};
    await GganbuPostModel().getPostDoc(address: address).then((post) {
      postData = post.data() as Map<String, dynamic>;
    });
    return postData;
  }

  Future<void> updatePostTime(
      {required String address, required DateTime postTime}) async {
    Map<String, dynamic> data = {
      'postTime': postTime,
    };
    await GganbuPostModel().updatePost(
      address: address,
      postData: data,
    );
  }

  Future<void> removePostData({required String address}) async {
    await GganbuPostModel().removePost(address: address);
  }
}
