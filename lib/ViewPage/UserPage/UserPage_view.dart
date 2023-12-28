import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class UserPage extends ConsumerWidget {
  final Map<String, dynamic> userData;
  const UserPage({super.key, required this.userData});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String> noShowItem = ['나침반', '부적', '문장'],
        equipArmor = ['투구', '상의', '하의', '장갑', '어깨'],
        equipAccessory = ['목걸이', '귀걸이', '반지'];
    String bracelet = '팔찌';

    String? cardEffect;
    if (userData['ArmoryCard']['Effects'].length >= 2) {
      userData['ArmoryCard']['Effects'][0]['Items'].length >=
              userData['ArmoryCard']['Effects'].last['Items'].length
          ? cardEffect =
              userData['ArmoryCard']['Effects'][0]['Items'].last['Name']
          : cardEffect =
              userData['ArmoryCard']['Effects'].last['Items'].last['Name'];
    }

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(top: 44.h, bottom: 44.h),
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
                    height: 70.h,
                    padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 21, 24, 29),
                      borderRadius: BorderRadius.circular(8.sp),
                    ),
                    child: userData['Collectibles'] != null
                        ? ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: userData['Collectibles'].length,
                            itemBuilder: (BuildContext ctx, int idx) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 24.w,
                                    height: 24.h,
                                    child: Image.asset(
                                        'assets/images/collect_0$idx.png'),
                                  ),
                                  Text(
                                    userData['Collectibles'][idx]['Point']
                                        .toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ],
                              );
                            },
                            separatorBuilder: (ctx, idx) {
                              return SizedBox(width: 10.w);
                            },
                          )
                        : Text(
                            '수집품 정보가 없습니다.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                            ),
                          ),
                  ),
                ),
                Container(
                  height: 20.h,
                  margin: EdgeInsets.symmetric(vertical: 20.h),
                  color: Colors.grey[200],
                ),
                userData['ArmoryGem'] != null
                    ? SizedBox(
                        width: double.infinity,
                        height: 70.w,
                        child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: const ClampingScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 10.w),
                          itemCount: userData['ArmoryGem']['Gems'].length,
                          itemBuilder: (BuildContext ctx, int idx) {
                            return Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                Container(
                                  width: 50.w,
                                  height: 50.w,
                                  padding: EdgeInsets.all(4.w),
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 21, 24, 29),
                                    borderRadius: BorderRadius.circular(8.sp),
                                  ),
                                  child: Image.network(userData['ArmoryGem']
                                      ['Gems'][idx]['Icon']),
                                ),
                                Transform.translate(
                                  offset: Offset(5.w, 5.w),
                                  child: Container(
                                    width: 24.w,
                                    height: 24.w,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color:
                                          const Color.fromARGB(255, 21, 24, 29),
                                      borderRadius: BorderRadius.circular(8.sp),
                                      border: Border.all(
                                        color: userData['ArmoryGem']['Gems']
                                                    [idx]['Grade'] ==
                                                '유물'
                                            ? Colors.deepOrange[400]!
                                            : userData['ArmoryGem']['Gems'][idx]
                                                        ['Grade'] ==
                                                    '전설'
                                                ? Colors.yellow[800]!
                                                : Colors.purple[800]!,
                                        width: 2.sp,
                                      ),
                                    ),
                                    child: Text(
                                      userData['ArmoryGem']['Gems'][idx]
                                              ['Level']
                                          .toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (ctx, idx) {
                            return SizedBox(width: 6.w);
                          },
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Container(
                          width: double.infinity,
                          height: 50.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 21, 24, 29),
                            borderRadius: BorderRadius.circular(8.sp),
                          ),
                          child: Text(
                            '장착한 보석이 없습니다.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                            ),
                          ),
                        ),
                      ),
                Divider(
                  color: Colors.grey[300],
                  thickness: 2.h,
                  height: 40.h,
                ),
                userData['ArmoryCard'] != null
                    ? Column(
                        children: [
                          if (userData['ArmoryCard']['Effects'] != null)
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: SizedBox(
                                width: double.infinity,
                                height: 40.h,
                                child: Text(
                                  cardEffect ??
                                      userData['ArmoryCard']['Effects'][0]
                                              ['Items']
                                          .last['Name'],
                                  style: TextStyle(
                                    color: Colors.deepOrange[400],
                                    fontSize: 18.sp,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          SizedBox(
                            width: double.infinity,
                            height: 120.w,
                            child: ListView.separated(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: const ClampingScrollPhysics(),
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              itemCount: userData['ArmoryCard']['Cards'].length,
                              itemBuilder: (BuildContext ctx, int idx) {
                                return Container(
                                  padding: EdgeInsets.all(4.w),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 21, 24, 29),
                                    borderRadius: BorderRadius.circular(8.sp),
                                  ),
                                  child: Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      Image.network(userData['ArmoryCard']
                                          ['Cards'][idx]['Icon']),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 20.w,
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              scrollDirection: Axis.horizontal,
                                              itemCount: userData['ArmoryCard']
                                                  ['Cards'][idx]['AwakeCount'],
                                              itemBuilder:
                                                  (BuildContext ctx, int idx) {
                                                return Image.asset(
                                                    'assets/images/gem_active.png');
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20.w,
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              scrollDirection: Axis.horizontal,
                                              itemCount: userData['ArmoryCard']
                                                          ['Cards'][idx]
                                                      ['AwakeTotal'] -
                                                  userData['ArmoryCard']
                                                          ['Cards'][idx]
                                                      ['AwakeCount'],
                                              itemBuilder:
                                                  (BuildContext ctx, int idx) {
                                                return Image.asset(
                                                    'assets/images/gem_deactive.png');
                                              },
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (ctx, idx) {
                                return SizedBox(width: 2.w);
                              },
                            ),
                          ),
                        ],
                      )
                    : Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Container(
                          width: double.infinity,
                          height: 50.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 21, 24, 29),
                            borderRadius: BorderRadius.circular(8.sp),
                          ),
                          child: Text(
                            '장착한 카드가 없습니다.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                            ),
                          ),
                        ),
                      ),
                Divider(
                  color: Colors.grey[300],
                  thickness: 2.h,
                  height: 40.h,
                ),
                userData['ArmoryEngraving'] != null
                    ? Container(
                        width: double.infinity,
                        height: 70.w,
                        alignment: Alignment.center,
                        child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: const ClampingScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 10.w),
                          itemCount:
                              userData['ArmoryEngraving']['Effects'].length,
                          itemBuilder: (BuildContext ctx, int idx) {
                            return Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                Container(
                                  width: 50.w,
                                  height: 50.w,
                                  padding: EdgeInsets.all(4.w),
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 21, 24, 29),
                                    borderRadius: BorderRadius.circular(8.sp),
                                  ),
                                  child: Image.network(
                                      userData['ArmoryEngraving']['Effects']
                                          [idx]['Icon']),
                                ),
                                Transform.translate(
                                  offset: Offset(5.w, 5.w),
                                  child: Container(
                                    width: 24.w,
                                    height: 24.w,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color:
                                          const Color.fromARGB(255, 21, 24, 29),
                                      borderRadius: BorderRadius.circular(8.sp),
                                      border: Border.all(
                                        color: Colors.deepOrange[400]!,
                                        width: 2.sp,
                                      ),
                                    ),
                                    child: Text(
                                      userData['ArmoryEngraving']['Effects']
                                              [idx]['Name'][
                                          userData['ArmoryEngraving']['Effects']
                                                      [idx]['Name']
                                                  .length -
                                              1],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (ctx, idx) {
                            return SizedBox(width: 8.w);
                          },
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Container(
                          width: double.infinity,
                          height: 50.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 21, 24, 29),
                            borderRadius: BorderRadius.circular(8.sp),
                          ),
                          child: Text(
                            '활성화 된 각인이 없습니다.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                            ),
                          ),
                        ),
                      ),
                SizedBox(height: 20.h),
                userData['ArmoryEngraving'] != null
                    ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount:
                              userData['ArmoryEngraving']['Effects'].length,
                          itemBuilder: (BuildContext ctx, int idx) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userData['ArmoryEngraving']['Effects'][idx]
                                          ['Name']
                                      .replaceFirstMapped(
                                          'Lv. ', (match) => ''),
                                  style: TextStyle(
                                    color: userData['ArmoryEngraving']
                                                ['Effects'][idx]['Name']
                                            .contains('감소')
                                        ? Colors.red
                                        : Colors.black,
                                    fontSize: 18.sp,
                                  ),
                                ),
                                Text(
                                  userData['ArmoryEngraving']['Effects'][idx]
                                      ['Description'],
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (ctx, idx) {
                            return SizedBox(height: 10.h);
                          },
                        ),
                      )
                    : const SizedBox(),
                Divider(
                  color: Colors.grey[300],
                  thickness: 2.h,
                  height: 40.h,
                ),
                userData['ArmoryEquipment'] != null
                    ? Container(
                        alignment: Alignment.topLeft,
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 10.w),
                          itemCount: userData['ArmoryEquipment'].length,
                          itemBuilder: (BuildContext ctx, int idx) {
                            Map<String, dynamic> tooltip = jsonDecode(
                                userData['ArmoryEquipment'][idx]['Tooltip']);
                            String ablitiyStone = 'Element_006';
                            String transcendence = 'Element_008',
                                elixir = 'Element_009';

                            if (tooltip['Element_007'] != null) {
                              transcendence =
                                  tooltip['Element_007']['type'] == 'Progress'
                                      ? 'Element_008'
                                      : 'Element_007';
                              elixir =
                                  tooltip['Element_007']['type'] == 'Progress'
                                      ? 'Element_009'
                                      : 'Element_008';
                              if (tooltip[transcendence]['type'] ==
                                      'IndentStringGroup' &&
                                  tooltip[transcendence]['value']['Element_000']
                                          ['contentStr']['Element_005'] ==
                                      null) {
                                elixir = transcendence;
                              }
                            }

                            if (userData['ArmoryEquipment'][idx]['Type'] ==
                                    '어빌리티 스톤' &&
                                tooltip[ablitiyStone]['type'] !=
                                    'IndentStringGroup' &&
                                tooltip['Element_005']['type'] ==
                                    'IndentStringGroup') {
                              ablitiyStone = 'Element_005';
                            }

                            return noShowItem.contains(
                                    userData['ArmoryEquipment'][idx]['Type'])
                                ? const SizedBox()
                                : SizedBox(
                                    child: Row(
                                      children: [
                                        Stack(
                                          alignment:
                                              AlignmentDirectional.bottomEnd,
                                          children: [
                                            Container(
                                              width: 50.w,
                                              height: 50.w,
                                              padding: EdgeInsets.all(4.w),
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 21, 24, 29),
                                                borderRadius:
                                                    BorderRadius.circular(8.sp),
                                                border: Border.all(
                                                  width: 2.sp,
                                                  color: userData['ArmoryEquipment']
                                                              [idx]['Grade'] ==
                                                          '에스더'
                                                      ? Colors.cyanAccent
                                                      : userData['ArmoryEquipment']
                                                                      [idx]
                                                                  ['Grade'] ==
                                                              '고대'
                                                          ? const Color.fromARGB(
                                                              255, 186, 169, 128)
                                                          : userData['ArmoryEquipment']
                                                                          [idx][
                                                                      'Grade'] ==
                                                                  '유물'
                                                              ? Colors.deepOrange[
                                                                  400]!
                                                              : userData['ArmoryEquipment'][idx]
                                                                          ['Grade'] ==
                                                                      '전설'
                                                                  ? Colors.yellow[800]!
                                                                  : Colors.purple[800]!,
                                                ),
                                              ),
                                              child: Image.network(
                                                  userData['ArmoryEquipment']
                                                      [idx]['Icon']),
                                            ),
                                            if (tooltip['Element_001']['value']
                                                    ['qualityValue'] >=
                                                0)
                                              Transform.translate(
                                                offset: Offset(0, 10.w),
                                                child: Container(
                                                  width: 50.w,
                                                  height: 20.w,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: const Color.fromARGB(
                                                        255, 21, 24, 29),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.sp),
                                                    border: Border.all(
                                                      color: Colors.white,
                                                      width: 2.sp,
                                                    ),
                                                  ),
                                                  child: Text(
                                                    tooltip['Element_001']
                                                                ['value']
                                                            ['qualityValue']
                                                        .toString(),
                                                    style: TextStyle(
                                                      color: tooltip['Element_001']
                                                                      ['value'][
                                                                  'qualityValue'] ==
                                                              100
                                                          ? Colors.amber[800]
                                                          : tooltip['Element_001']
                                                                          ['value'][
                                                                      'qualityValue'] >=
                                                                  90
                                                              ? Colors
                                                                  .purpleAccent
                                                              : tooltip['Element_001']
                                                                              ['value']
                                                                          [
                                                                          'qualityValue'] >=
                                                                      70
                                                                  ? Colors
                                                                      .blueAccent
                                                                  : Colors.greenAccent[
                                                                      400],
                                                      fontSize: 12.sp,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                        SizedBox(width: 10.w),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              userData['ArmoryEquipment'][idx]
                                                  ['Name'],
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14.sp,
                                              ),
                                            ),
                                            //엘릭서
                                            if (equipArmor.contains(
                                                    userData['ArmoryEquipment']
                                                        [idx]['Type']) &&
                                                tooltip[elixir] != null &&
                                                tooltip[elixir]['type'] ==
                                                    'IndentStringGroup' &&
                                                tooltip[elixir]['value']
                                                        ['Element_000'] !=
                                                    null)
                                              Row(
                                                children: [
                                                  if (tooltip[elixir]['value'][
                                                                  'Element_000']
                                                              ['contentStr']
                                                          ['Element_000'] !=
                                                      null)
                                                    Text(
                                                      tooltip[elixir]['value']['Element_000']
                                                                          [
                                                                          'contentStr']
                                                                      [
                                                                      'Element_000']
                                                                  ['contentStr']
                                                              .replaceAllMapped(
                                                                  RegExp(
                                                                      r'<[^>]*>'),
                                                                  (match) {
                                                                return '';
                                                              })
                                                              .substring(
                                                                0,
                                                                tooltip[elixir]['value']['Element_000']['contentStr']['Element_000']['contentStr'].replaceAllMapped(
                                                                        RegExp(
                                                                            r'<[^>]*>'),
                                                                        (match) {
                                                                      return '';
                                                                    }).indexOf(
                                                                        'Lv.') +
                                                                    4,
                                                              )
                                                              .replaceFirstMapped(
                                                                  'Lv.',
                                                                  (match) => '')
                                                              .replaceAllMapped(
                                                                  RegExp(
                                                                      r'\[.*?\]'),
                                                                  (match) {
                                                                return '';
                                                              }) ??
                                                          '',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14.sp,
                                                      ),
                                                    ),
                                                  Text(
                                                    ' /',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14.sp,
                                                    ),
                                                  ),
                                                  if (tooltip[elixir]['value'][
                                                                  'Element_000']
                                                              ['contentStr']
                                                          ['Element_001'] !=
                                                      null)
                                                    Text(
                                                      tooltip[elixir]['value']['Element_000']
                                                                          [
                                                                          'contentStr']
                                                                      [
                                                                      'Element_001']
                                                                  ['contentStr']
                                                              .replaceAllMapped(
                                                                  RegExp(
                                                                      r'<[^>]*>'),
                                                                  (match) {
                                                                return '';
                                                              })
                                                              .substring(
                                                                0,
                                                                tooltip[elixir]['value']['Element_000']['contentStr']['Element_001']['contentStr'].replaceAllMapped(
                                                                        RegExp(
                                                                            r'<[^>]*>'),
                                                                        (match) {
                                                                      return '';
                                                                    }).indexOf(
                                                                        'Lv.') +
                                                                    4,
                                                              )
                                                              .replaceFirstMapped(
                                                                  'Lv.',
                                                                  (match) => '')
                                                              .replaceAllMapped(
                                                                  RegExp(
                                                                      r'\[.*?\]'),
                                                                  (match) {
                                                                return '';
                                                              }) ??
                                                          '',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14.sp,
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            //초월
                                            if (equipArmor.contains(
                                                    userData['ArmoryEquipment']
                                                        [idx]['Type']) &&
                                                tooltip[transcendence] !=
                                                    null &&
                                                tooltip[transcendence]
                                                        ['type'] ==
                                                    'IndentStringGroup' &&
                                                tooltip[transcendence]['value']
                                                                ['Element_000']
                                                            ['contentStr']
                                                        ['Element_005'] !=
                                                    null)
                                              Text(
                                                tooltip[transcendence]['value']
                                                            ['Element_000']
                                                        ['topStr']
                                                    .replaceAllMapped(
                                                        RegExp(r'<[^>]*>'),
                                                        (match) {
                                                  return '';
                                                }),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.sp,
                                                ),
                                              ),
                                            //악세서리
                                            if (equipAccessory.contains(
                                                    userData['ArmoryEquipment']
                                                        [idx]['Type']) &&
                                                tooltip['Element_006'] !=
                                                    null &&
                                                tooltip['Element_006']
                                                        ['type'] ==
                                                    'IndentStringGroup')
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        tooltip['Element_006']['value']
                                                                            [
                                                                            'Element_000']
                                                                        [
                                                                        'contentStr']
                                                                    [
                                                                    'Element_000']
                                                                ['contentStr']
                                                            .replaceAllMapped(
                                                                RegExp(
                                                                    r'<[^>]*>'),
                                                                (match) {
                                                          return '';
                                                        }).replaceFirstMapped(
                                                                ' 활성도',
                                                                (match) => ''),
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14.sp,
                                                        ),
                                                      ),
                                                      const Text(' '),
                                                      Text(
                                                        tooltip['Element_006']['value']
                                                                            [
                                                                            'Element_000']
                                                                        [
                                                                        'contentStr']
                                                                    [
                                                                    'Element_001']
                                                                ['contentStr']
                                                            .replaceAllMapped(
                                                                RegExp(
                                                                    r'<[^>]*>'),
                                                                (match) {
                                                          return '';
                                                        }).replaceFirstMapped(
                                                                ' 활성도',
                                                                (match) => ''),
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14.sp,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    tooltip['Element_006']['value']
                                                                        [
                                                                        'Element_000']
                                                                    [
                                                                    'contentStr']
                                                                ['Element_002']
                                                            ['contentStr']
                                                        .replaceAllMapped(
                                                            RegExp(r'<[^>]*>'),
                                                            (match) {
                                                      return '';
                                                    }).replaceFirstMapped(
                                                            ' 활성도',
                                                            (match) => ''),
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 14.sp,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            //어빌리티 스톤
                                            if (userData['ArmoryEquipment'][idx]
                                                        ['Type'] ==
                                                    '어빌리티 스톤' &&
                                                tooltip[ablitiyStone] != null &&
                                                tooltip[ablitiyStone]['type'] ==
                                                    'IndentStringGroup')
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        tooltip[ablitiyStone]['value']
                                                                            [
                                                                            'Element_000']
                                                                        [
                                                                        'contentStr']
                                                                    [
                                                                    'Element_000']
                                                                ['contentStr']
                                                            .replaceAllMapped(
                                                                RegExp(
                                                                    r'<[^>]*>'),
                                                                (match) {
                                                          return '';
                                                        }).replaceFirstMapped(
                                                                ' 활성도',
                                                                (match) => ''),
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14.sp,
                                                        ),
                                                      ),
                                                      const Text(' '),
                                                      Text(
                                                        tooltip[ablitiyStone]['value']
                                                                            [
                                                                            'Element_000']
                                                                        [
                                                                        'contentStr']
                                                                    [
                                                                    'Element_001']
                                                                ['contentStr']
                                                            .replaceAllMapped(
                                                                RegExp(
                                                                    r'<[^>]*>'),
                                                                (match) {
                                                          return '';
                                                        }).replaceFirstMapped(
                                                                ' 활성도',
                                                                (match) => ''),
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14.sp,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    tooltip[ablitiyStone]['value']
                                                                        [
                                                                        'Element_000']
                                                                    [
                                                                    'contentStr']
                                                                ['Element_002']
                                                            ['contentStr']
                                                        .replaceAllMapped(
                                                            RegExp(r'<[^>]*>'),
                                                            (match) {
                                                      return '';
                                                    }).replaceFirstMapped(
                                                            ' 활성도',
                                                            (match) => ''),
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 14.sp,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            //팔찌
                                            if (userData['ArmoryEquipment'][idx]
                                                        ['Type'] ==
                                                    bracelet &&
                                                tooltip['Element_004'] !=
                                                    null &&
                                                tooltip['Element_004']
                                                        ['type'] ==
                                                    'ItemPartBox')
                                              Text(
                                                tooltip['Element_004']['value']
                                                        ['Element_001']
                                                    .replaceAll('<BR>', ',')
                                                    .replaceAll(' ', '')
                                                    .replaceAll(
                                                        RegExp(r'].*?</img>'),
                                                        '], ')
                                                    .replaceAll(
                                                        RegExp(
                                                            r"\((.*?)\)|<[^>]*>"),
                                                        '')
                                                    .replaceAll(',,', ',')
                                                    .replaceAll(',', ', ')
                                                    .replaceAll(
                                                        RegExp(r'][가-힣]+.*'),
                                                        ']')
                                                    .replaceAll(', 효과부여가능', ''),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 10.sp,
                                                ),
                                              )
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                          },
                          separatorBuilder: (ctx, idx) {
                            return SizedBox(
                              height: 18.h,
                            );
                          },
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Container(
                          width: double.infinity,
                          height: 50.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 21, 24, 29),
                            borderRadius: BorderRadius.circular(8.sp),
                          ),
                          child: Text(
                            '장착중인 장비가 없습니다.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                            ),
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
