import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:loaduo/Report/Report_view.dart';
import 'package:loaduo/ShowToastMsg.dart';
import 'AnonymousChatting_viewmodel.dart';
import 'package:loaduo/ViewPage/GganbuPage/LoaTalk/MatchMaking/MatchMaking_model.dart';

class AnonymousChattingPage extends StatefulWidget {
  final Map<dynamic, dynamic> info;
  final String otherPerson, address;
  const AnonymousChattingPage({
    super.key,
    required this.info,
    required this.address,
    required this.otherPerson,
  });

  @override
  State<AnonymousChattingPage> createState() => _AnonymousChattingPageState();
}

class _AnonymousChattingPageState extends State<AnonymousChattingPage> {
  String? userUID = FirebaseAuth.instance.currentUser!.uid;
  TextEditingController messageController = TextEditingController();
  String inputMessage = '';
  late String otherPerson, address;
  late Map<dynamic, dynamic> info;
  @override
  void initState() {
    otherPerson = widget.otherPerson;
    address = widget.address;
    info = widget.info;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              centerTitle: false,
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.transparent,
              titleSpacing: 2,
              leading: IconButton(
                onPressed: () async {
                  MatchMakingModel().initializeAnonymousChatting(uid: userUID!);
                  AnonymousChattingViewModel().sendMessage(
                    address: address,
                    name: '시스템 메시지',
                    server: '시스템',
                    uid: 'system',
                    text: '상대방이 대화방을 나갔습니다.',
                    sendTime: DateTime.now(),
                  );
                  Future.microtask(() => Navigator.pop(context));
                },
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
              ),
              actions: [
                IconButton(
                  onPressed: () async {
                    //친구 맺기 눌렀을 때 채팅으로 친구 요청 메시지 발송
                    //친구맺기 기능을 위해 사전에 원정대 등록 확인 후 입장하는 걸로 일단
                    AnonymousChattingViewModel().sendMessage(
                      address: address,
                      name: info['name'],
                      server: info['server'],
                      uid: userUID!,
                      text: '##### 친구맺기신청 #####',
                      sendTime: DateTime.now(),
                    );
                  },
                  icon: const Text('친구맺기'),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 16.w),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProgressHUD(
                            child: Report(
                              postType: 'AnonymousChatting',
                              uid: otherPerson,
                              address: address,
                            ),
                          ),
                        ),
                      );
                    },
                    icon: const Text(
                      '신고',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
              ],
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
                        Map<dynamic, dynamic> thisMessage =
                            chatToList[idx].value;
                        Map<dynamic, dynamic>? beforeMessage;
                        if (idx != 0) {
                          beforeMessage = chatToList[idx - 1].value;
                        }
                        bool isMe = thisMessage['uid'] == userUID;
                        bool isSystem = thisMessage['uid'] == 'system';
                        DateTime sendTime =
                            DateTime.parse(thisMessage['sendTime']);
                        bool afternoon = sendTime.hour >= 12;

                        return Align(
                          alignment: isSystem
                              ? Alignment.center
                              : isMe
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                          child: Column(
                            children: [
                              if (!isSystem &&
                                  !isMe &&
                                  (beforeMessage == null ||
                                      thisMessage['uid'] !=
                                          beforeMessage['uid']))
                                Container(
                                  width: double.infinity,
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 4.h),
                                    child: Text(
                                      '익명의 상대',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              Row(
                                mainAxisAlignment: isSystem
                                    ? MainAxisAlignment.center
                                    : isMe
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
                                  //메시지
                                  if (thisMessage['text'] !=
                                      '##### 친구맺기신청 #####')
                                    Container(
                                      constraints:
                                          BoxConstraints(maxWidth: 200.w),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w, vertical: 10.h),
                                      decoration: BoxDecoration(
                                        color: isMe
                                            ? Colors.deepOrange[400]
                                            : Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(8.sp),
                                      ),
                                      child: Text(
                                        thisMessage['text'],
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: isMe
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: isSystem ? 12.sp : 16.sp,
                                        ),
                                      ),
                                    ),
                                  //친구 맺기 신청
                                  if (thisMessage['text'] ==
                                      '##### 친구맺기신청 #####')
                                    Container(
                                      constraints:
                                          BoxConstraints(maxWidth: 200.w),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w, vertical: 10.h),
                                      decoration: BoxDecoration(
                                        color: isMe
                                            ? Colors.deepOrange[400]
                                            : Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(8.sp),
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            '친구맺기를 요청했습니다.',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: isMe
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                          SizedBox(height: 20.h),
                                          if (!isMe)
                                            InkWell(
                                              onTap: () async {
                                                if (!isMe) {
                                                  //채팅 이동 로직
                                                  await AnonymousChattingViewModel()
                                                      .addMyChat(
                                                    me: userUID!,
                                                    otherPerson: otherPerson,
                                                    address: address,
                                                  )
                                                      .then((result) {
                                                    if (result) {
                                                      //시스템 메시지 발송
                                                      AnonymousChattingViewModel()
                                                          .sendMessage(
                                                        address: address,
                                                        name: '시스템 메시지',
                                                        server: '시스템',
                                                        uid: 'system',
                                                        text:
                                                            '친구맺기가 완료되었습니다.\n지금부터 이곳에 작성하는 메시지는\n친구채팅에 저장되지않습니다.',
                                                        sendTime:
                                                            DateTime.now(),
                                                      );
                                                    } else {
                                                      showToast(
                                                          '이미 채팅이 활성화 상태인 대상이거나,\n알 수 없는 오류로 인해\n친구맺기에 실패하였습니다.');
                                                    }
                                                  });
                                                }
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 4.w),
                                                child: Container(
                                                  width: double.infinity,
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 4.w,
                                                    vertical: 10.h,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: isMe
                                                        ? Colors.grey
                                                        : Colors
                                                            .deepOrange[400],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.sp),
                                                  ),
                                                  child: Text(
                                                    '수락하기',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14.sp,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          SizedBox(height: 10.h),
                                        ],
                                      ),
                                    ),
                                  if (!isSystem && !isMe) SizedBox(width: 4.w),
                                  if (!isSystem && !isMe)
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
                      await AnonymousChattingViewModel().sendMessage(
                        address: address,
                        name: info['name'],
                        server: info['server'],
                        uid: userUID!,
                        text: text,
                        sendTime: now,
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
      ),
    );
  }
}
