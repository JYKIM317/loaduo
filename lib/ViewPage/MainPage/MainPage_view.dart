import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'MainPage_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:loaduo/ViewPage/MyPage/MyPage_view.dart';
import 'package:loaduo/ViewPage/SearchUserPage/SearchUserPage_view.dart';
import 'package:loaduo/ViewPage/GganbuPage/GganbuPage_view.dart';
import 'package:loaduo/CustomIcon.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  String? userUID = FirebaseAuth.instance.currentUser!.uid;

  Future<void> initPlugin() async {
    try {
      final TrackingStatus status =
          await AppTrackingTransparency.trackingAuthorizationStatus;
      if (status == TrackingStatus.notDetermined) {
        await Future.delayed(const Duration(milliseconds: 200));
        final TrackingStatus status =
            await AppTrackingTransparency.requestTrackingAuthorization();
        debugPrint(status.toString());
      }
    } on PlatformException {
      debugPrint('PlatformException was thrown');
    }
  }

  @override
  void initState() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;

      var androidNotiDetails = const AndroidNotificationDetails(
        'high_importance_channel',
        'High Importance Notifications',
        channelDescription: 'This channel is used for important notifications.',
        importance: Importance.high,
      );
      var iOSNotiDetails = const DarwinNotificationDetails();
      var details = NotificationDetails(
        android: androidNotiDetails,
        iOS: iOSNotiDetails,
      );

      if (notification != null) {
        FlutterLocalNotificationsPlugin().show(
          notification.hashCode,
          notification.title,
          notification.body,
          details,
        );
      }

      FirebaseMessaging.onMessageOpenedApp.listen((message) {});

      FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) async {
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(userUID)
            .update({'fcmToken': fcmToken});
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => initPlugin());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    userUID = FirebaseAuth.instance.currentUser!.uid;
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
            ProgressHUD(child: MyPage(uid: userUID!)),
          ][currentIndex],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CustomIcon.thLarge),
            label: '구인 구직',
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
