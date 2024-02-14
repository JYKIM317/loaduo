import 'package:loaduo/CustomIcon.dart';
import 'ChattingPage_viewmodel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:loaduo/Report/Report_view.dart';
import 'package:loaduo/ViewPage/MyPage/MyPage_view.dart';

class ChattingPage extends StatefulWidget {
  final Map<dynamic, dynamic> info;
  final Map<dynamic, dynamic> otherPersonInfo;
  final Map<dynamic, dynamic>? raidInfo;
  final List<dynamic> members;
  final String address;
  const ChattingPage({
    super.key,
    required this.info,
    required this.address,
    required this.otherPersonInfo,
    required this.members,
    this.raidInfo,
  });

  @override
  State<ChattingPage> createState() => _ChattingPageState();
}

class _ChattingPageState extends State<ChattingPage> {
  String? userUID = FirebaseAuth.instance.currentUser!.uid;
  TextEditingController messageController = TextEditingController();
  String inputMessage = '';
  late String address;
  late Map<dynamic, dynamic> info;
  late Map<dynamic, dynamic> otherPersonInfo;
  late Map<dynamic, dynamic>? raidInfo;
  @override
  void initState() {
    address = widget.address;
    info = widget.info;
    otherPersonInfo = widget.otherPersonInfo;
    raidInfo = widget.raidInfo;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> members = widget.members;
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            centerTitle: false,
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
            titleSpacing: 2,
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 16.w),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProgressHUD(
                          child: Report(
                            postType: 'Chatting',
                            uid: raidInfo == null
                                ? otherPersonInfo['uid']
                                : 'raid',
                            address: address,
                          ),
                        ),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.error,
                    color: Colors.red[400],
                    size: 24.sp,
                  ),
                ),
              )
            ],
            title: Row(
              children: [
                Text.rich(
                  TextSpan(
                    text: raidInfo != null
                        ? raidInfo!['title']
                        : otherPersonInfo['name'],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.sp,
                    ),
                    children: <TextSpan>[
                      const TextSpan(text: ' '),
                      TextSpan(
                        text: raidInfo != null
                            ? raidInfo!['subtitle']
                            : otherPersonInfo['server'],
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 4.w),
                if (raidInfo == null)
                  Icon(
                    otherPersonInfo['credential']
                        ? CustomIcon.check
                        : CustomIcon.checkEmpty,
                    size: 21.sp,
                    color: Colors.black,
                  ),
              ],
            ),
          ),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.grey[200],
            alignment: Alignment.topCenter,
            child: StreamBuilder(
              stream: FirebaseDatabase.instance.ref(address).onValue,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                Map<dynamic, dynamic>? chatList =
                    snapshot.data?.snapshot.value as Map<dynamic, dynamic>?;
                if (chatList == null || chatList.isEmpty) {
                  return const SizedBox();
                }
                List<MapEntry<dynamic, dynamic>> chatToList =
                    chatList.entries.toList();
                chatToList.sort(
                  (a, b) {
                    DateTime timeA = DateTime.parse(a.value['sendTime']);
                    DateTime timeB = DateTime.parse(b.value['sendTime']);
                    return timeA.compareTo(timeB);
                  },
                );
                /* 채팅 100개 이상일 시 최적화를 위해 대화 삭제 */
                if (chatToList.length >= 100) {
                  FirebaseDatabase.instance
                      .ref('$address/${chatToList.first.key}')
                      .remove();
                }
                /* ^ 중요한 로직 ^ */

                return SingleChildScrollView(
                  reverse: true,
                  physics: const BouncingScrollPhysics(),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 32.h,
                    ),
                    itemCount: chatToList.length,
                    itemBuilder: (BuildContext ctx, int idx) {
                      Map<dynamic, dynamic> thisMessage = chatToList[idx].value;
                      Map<dynamic, dynamic>? beforeMessage;
                      if (idx != 0) {
                        beforeMessage = chatToList[idx - 1].value;
                      }
                      bool isMe = thisMessage['uid'] == userUID;
                      DateTime sendTime =
                          DateTime.parse(thisMessage['sendTime']);
                      bool afternoon = sendTime.hour >= 12;

                      return Align(
                        alignment:
                            isMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: Column(
                          children: [
                            if (!isMe &&
                                (beforeMessage == null ||
                                    thisMessage['uid'] != beforeMessage['uid']))
                              Container(
                                width: double.infinity,
                                alignment: Alignment.bottomLeft,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProgressHUD(
                                          child: Material(
                                              child: MyPage(
                                                  uid: thisMessage['uid'])),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 4.h),
                                    child: Text.rich(
                                      TextSpan(
                                        text: thisMessage['name'],
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.sp,
                                        ),
                                        children: <TextSpan>[
                                          if (!isMe)
                                            TextSpan(
                                              text: ' ${thisMessage['server']}',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12.sp,
                                              ),
                                            )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            Row(
                              mainAxisAlignment: isMe
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                if (isMe)
                                  Text(
                                    '${afternoon ? '오후' : '오전'} ${sendTime.hour > 12 ? sendTime.hour - 12 : sendTime.hour}:${sendTime.minute.toString().padLeft(2, '0')}',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                if (isMe) SizedBox(width: 4.w),
                                Container(
                                  constraints: BoxConstraints(maxWidth: 200.w),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 10.h),
                                  decoration: BoxDecoration(
                                    color: isMe
                                        ? Colors.deepOrange[400]
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(8.sp),
                                  ),
                                  child: Text(
                                    thisMessage['text'] != '##### 친구맺기신청 #####'
                                        ? thisMessage['text']
                                        : ' ',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: isMe ? Colors.white : Colors.black,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                ),
                                if (!isMe) SizedBox(width: 4.w),
                                if (!isMe)
                                  Text(
                                    '${afternoon ? '오후' : '오전'} ${sendTime.hour > 12 ? sendTime.hour - 12 : sendTime.hour}:${sendTime.minute.toString().padLeft(2, '0')}',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (ctx, idx) {
                      DateTime thisMessageTime =
                          DateTime.parse(chatToList[idx].value['sendTime']);
                      DateTime nextMessageTime = DateTime.parse(
                          chatToList[idx + 1].value['sendTime'] ??
                              thisMessageTime.toString());

                      if (nextMessageTime.difference(thisMessageTime).inDays >=
                          1) {
                        return Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 20.h),
                            padding: EdgeInsets.symmetric(
                                horizontal: 50.w, vertical: 10.h),
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(16.sp),
                            ),
                            child: Text(
                              '${nextMessageTime.year}년 ${nextMessageTime.month}월 ${nextMessageTime.day}일',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        );
                      }

                      return SizedBox(height: 10.h);
                    },
                  ),
                );
              },
            ),
          ),
          bottomNavigationBar: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: TextField(
                    minLines: 1,
                    maxLines: 3,
                    controller: messageController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    onChanged: (text) {
                      inputMessage = text;
                    },
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  if (inputMessage != '' && inputMessage.trim() != '') {
                    DateTime now = DateTime.now();
                    String text = inputMessage;
                    inputMessage = '';
                    messageController.text = '';
                    await ChattingPageViewModel().sendMessage(
                      address: address,
                      name: info['name'],
                      server: info['server'],
                      uid: userUID!,
                      text: text,
                      sendTime: now,
                      members: members,
                    );
                  }
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
                  color: Colors.deepOrange,
                  child: Icon(
                    Icons.send,
                    color: Colors.white,
                    size: 38.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
