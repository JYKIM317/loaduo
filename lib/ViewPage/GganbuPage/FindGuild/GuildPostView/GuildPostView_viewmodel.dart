import 'GuildPostView_model.dart';

class GuildPostViewModel {
  Future<Map<String, dynamic>> getPostData({required String address}) async {
    Map<String, dynamic> postData = {};
    await GuildPostModel().getPostDoc(address: address).then((post) {
      postData = post.data() as Map<String, dynamic>;
    });
    return postData;
  }

  Future<void> updatePostTime(
      {required String address, required DateTime postTime}) async {
    Map<String, dynamic> data = {
      'postTime': postTime,
    };
    await GuildPostModel().updatePost(
      address: address,
      postData: data,
    );
  }

  Future<void> removePostData({required String address}) async {
    await GuildPostModel().removePost(address: address);
  }
}
