import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loaduo/main_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

String? _apikey;
bool? _initialdata;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //Firebase auth login
  await FirebaseAuth.instance.signInAnonymously();
  _apikey = prefs.getString('apikey') ?? 'null';
  _initialdata = prefs.getBool('initaldata') ?? false;
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
    ref.read(apikey.notifier).update(_apikey!);
    _initialdata!
        ? ref.read(initialDataExist.notifier).existTrue()
        : ref.read(initialDataExist.notifier).existFalse();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        useMaterial3: true,
        fontFamily: 'NotoSans',
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
    if (myApiKey == 'null') return d;
    if (!myInitialDataExist) return d;
    return d;
  }
}
