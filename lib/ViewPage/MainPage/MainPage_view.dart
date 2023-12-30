import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'MainPage_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:loaduo/ViewPage/MyPage/MyPage_view.dart';
import 'package:loaduo/ViewPage/SearchUserPage/SearchUserPage_view.dart';
import 'package:loaduo/ViewPage/GganbuPage/GganbuPage_view.dart';

class MainPage extends ConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String? userUID = FirebaseAuth.instance.currentUser!.uid;
    final currentIndex = ref.watch(mainpageIndex);
    onBottomTapped(int index) {
      ref.read(mainpageIndex.notifier).update(index);
    }

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: [
            GganbuPage(),
            ProgressHUD(child: SearchUserPage()),
            ProgressHUD(child: MyPage(uid: userUID)),
          ][currentIndex],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.featured_play_list),
            label: '깐부 찾기',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '유저 검색',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_pin),
            label: '내 정보',
          ),
        ],
        currentIndex: currentIndex,
        onTap: onBottomTapped,
        backgroundColor: Colors.white,
        fixedColor: Colors.deepOrange[400],
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700),
      ),
    );
  }
}
