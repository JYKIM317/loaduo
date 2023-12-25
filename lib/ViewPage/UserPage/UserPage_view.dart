import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class UserPage extends ConsumerWidget {
  final Map<String, dynamic> userData;
  const UserPage({super.key, required this.userData});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //print(this.userData['ArmoryProfile']);
    //print(this.userData['ArmoryCard']);
    //print(this.userData['ArmoryGem']);
    //print(this.userData['ArmoryEquipment'][0][Name]);
    //print(this.userData['ArmoryEngraving']['Effects'][0][Icon, Name]);
    //print(this.userData['Collectibles']);
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(top: 44.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 21, 24, 29),
                      borderRadius: BorderRadius.circular(8.sp),
                    ),
                    child: Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        text:
                            '${userData['ArmoryProfile']['GuildName'] ?? ''}\n',
                        style: TextStyle(
                          color: Colors.green[700],
                          fontSize: 18.sp,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                '${userData['ArmoryProfile']['Title'] ?? ''} ',
                            style:
                                const TextStyle(color: Colors.lightGreenAccent),
                          ),
                          TextSpan(
                            text:
                                '${userData['ArmoryProfile']['CharacterName']}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    children: [
                      Container(
                        width: 200.w,
                        height: 320.h,
                        padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 21, 24, 29),
                          borderRadius: BorderRadius.circular(8.sp),
                        ),
                        child: Image.network(
                            userData['ArmoryProfile']['CharacterImage'] ?? ''),
                      ),
                      SizedBox(width: 2.w),
                      Expanded(
                        child: Container(
                          height: 320.h,
                          padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 21, 24, 29),
                            borderRadius: BorderRadius.circular(8.sp),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text.rich(
                                textAlign: TextAlign.center,
                                TextSpan(
                                    text: '서버 ',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14.sp,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: userData['ArmoryProfile']
                                                ['ServerName'] ??
                                            '',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.sp,
                                        ),
                                      )
                                    ]),
                              ),
                              Text.rich(
                                textAlign: TextAlign.center,
                                TextSpan(
                                    text: '클래스\n',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14.sp,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: userData['ArmoryProfile']
                                                ['CharacterClassName'] ??
                                            '',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.sp,
                                        ),
                                      )
                                    ]),
                              ),
                              Text.rich(
                                textAlign: TextAlign.center,
                                TextSpan(
                                    text: '아이템 레벨\n',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14.sp,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: userData['ArmoryProfile']
                                                ['ItemAvgLevel'] ??
                                            '',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.sp,
                                        ),
                                      )
                                    ]),
                              ),
                              Text.rich(
                                textAlign: TextAlign.center,
                                TextSpan(
                                    text: '캐릭터 레벨 ',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14.sp,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: userData['ArmoryProfile']
                                                ['CharacterLevel']
                                            .toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.sp,
                                        ),
                                      )
                                    ]),
                              ),
                              Text.rich(
                                textAlign: TextAlign.center,
                                TextSpan(
                                    text: '원정대 ',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14.sp,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: userData['ArmoryProfile']
                                                ['ExpeditionLevel']
                                            .toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.sp,
                                        ),
                                      )
                                    ]),
                              ),
                              Text.rich(
                                textAlign: TextAlign.center,
                                TextSpan(
                                    text: 'PVP ',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14.sp,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: userData['ArmoryProfile']
                                                ['PvpGradeName'] ??
                                            '',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.sp,
                                        ),
                                      )
                                    ]),
                              ),
                              Text.rich(
                                textAlign: TextAlign.center,
                                TextSpan(
                                    text: '영지 ',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14.sp,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text:
                                            '${userData['ArmoryProfile']['TownName'] ?? ''}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.sp,
                                        ),
                                      )
                                    ]),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 21, 24, 29),
                        borderRadius: BorderRadius.circular(8.sp),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                width: 24.w,
                                height: 24.h,
                                child:
                                    Image.asset('assets/images/collect_00.png'),
                              ),
                              Text(
                                userData['Collectibles'][0]['Point'].toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(
                                width: 24.w,
                                height: 24.h,
                                child:
                                    Image.asset('assets/images/collect_01.png'),
                              ),
                              Text(
                                userData['Collectibles'][1]['Point'].toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(
                                width: 24.w,
                                height: 24.h,
                                child:
                                    Image.asset('assets/images/collect_02.png'),
                              ),
                              Text(
                                userData['Collectibles'][2]['Point'].toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(
                                width: 24.w,
                                height: 24.h,
                                child:
                                    Image.asset('assets/images/collect_03.png'),
                              ),
                              Text(
                                userData['Collectibles'][3]['Point'].toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(
                                width: 24.w,
                                height: 24.h,
                                child:
                                    Image.asset('assets/images/collect_04.png'),
                              ),
                              Text(
                                userData['Collectibles'][4]['Point'].toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(
                                width: 24.w,
                                height: 24.h,
                                child:
                                    Image.asset('assets/images/collect_05.png'),
                              ),
                              Text(
                                userData['Collectibles'][5]['Point'].toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(
                                width: 24.w,
                                height: 24.h,
                                child:
                                    Image.asset('assets/images/collect_06.png'),
                              ),
                              Text(
                                userData['Collectibles'][6]['Point'].toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(
                                width: 24.w,
                                height: 24.h,
                                child:
                                    Image.asset('assets/images/collect_07.png'),
                              ),
                              Text(
                                userData['Collectibles'][7]['Point'].toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(
                                width: 24.w,
                                height: 24.h,
                                child:
                                    Image.asset('assets/images/collect_08.png'),
                              ),
                              Text(
                                userData['Collectibles'][8]['Point'].toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                ),
                Container(
                  height: 20.h,
                  margin: EdgeInsets.symmetric(vertical: 20.h),
                  color: Colors.grey[200],
                ),
                /*Container(
                    child: Image.network(
                        userData['ArmoryGem']['Gems'][0]['Icon'] ?? '')),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
