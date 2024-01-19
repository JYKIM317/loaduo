import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'ViewPage/InitialDataPages/ApiData/ApiDataPage_view.dart';
import 'ViewPage/InitialDataPages/InitialData/InitialDataPage_view.dart';
import 'ViewPage/MainPage/MainPage_view.dart';

String? _apikey;
bool? _initialdata;

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
}

void initializeNotification() async {
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  var initialzationSettingsIOS = const DarwinInitializationSettings(
    requestSoundPermission: true,
    requestBadgePermission: true,
    requestAlertPermission: true,
  );
  var initialzationSettingsAndroid =
      const AndroidInitializationSettings('@mipmap/ic_launcher');

  var initializationSettings = InitializationSettings(
    android: initialzationSettingsAndroid,
    iOS: initialzationSettingsIOS,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: false,
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  //Firebase auth login
  await FirebaseAuth.instance.signInAnonymously();
  _apikey = prefs.getString('apikey') ?? 'null';
  _initialdata = prefs.getBool('initialdata') ?? false;
  String? userUID = FirebaseAuth.instance.currentUser!.uid;

  initializeNotification();
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: false,
  );
  final fcmToken = await FirebaseMessaging.instance.getToken();

  try {
    await FirebaseFirestore.instance.collection('Users').doc(userUID).update({
      'lastLogin': DateTime.now(),
      'fcmToken': fcmToken,
    });
  } catch (e) {
    const String noDocError =
        '[cloud_firestore/not-found] Some requested document was not found.';
    if (e.toString() == noDocError) {
      await FirebaseFirestore.instance.collection('Users').doc(userUID).set({
        'lastLogin': DateTime.now(),
        'fcmToken': fcmToken,
      });
    }
  }

  runApp(
    const ProviderScope(
      child: ScreenUtilInit(
        designSize: Size(375, 812),
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        useMaterial3: true,
        fontFamily: 'Jamsil_M',
      ),
      home: RoutePage(),
    );
  }
}

class RoutePage extends ConsumerWidget {
  const RoutePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myApiKey = ref.watch(apikey);
    final myInitialDataExist = ref.watch(initialDataExist);
    if (myApiKey == 'null') {
      return ApiDataPage();
    }
    if (!myInitialDataExist) {
      return InitialDataPage();
    }
    return MainPage();
  }
}

/////////////////////////////////////
final apikey = StateNotifierProvider<ApikeyNotifier, String>((ref) {
  return ApikeyNotifier();
});

class ApikeyNotifier extends StateNotifier<String> {
  ApikeyNotifier() : super(_apikey ?? 'null');

  update(String apikey) {
    //final SharedPreferences prefs = await SharedPreferences.getInstance();
    //await prefs.setString('apikey', apikey);
    state = apikey;
  }
}

final initialDataExist =
    StateNotifierProvider<InitialDataNotifier, bool>((ref) {
  return InitialDataNotifier();
});

class InitialDataNotifier extends StateNotifier<bool> {
  InitialDataNotifier() : super(_initialdata ?? false);

  existTrue() {
    //final SharedPreferences prefs = await SharedPreferences.getInstance();
    //await prefs.setString('apikey', apikey);
    state = true;
  }

  existFalse() {
    //final SharedPreferences prefs = await SharedPreferences.getInstance();
    //await prefs.setString('apikey', apikey);
    state = false;
  }
}
