import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

class StaticPostView extends StatefulWidget {
  final Map<String, dynamic> post;
  const StaticPostView({super.key, required this.post});

  @override
  State<StaticPostView> createState() => _StaticPostViewState();
}

class _StaticPostViewState extends State<StaticPostView> {
  late Map<String, dynamic> post;
  String? userUID = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    post = widget.post;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final progress = ProgressHUD.of(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color.fromARGB(255, 21, 24, 29).withOpacity(0.9),
      ),
    );
  }
}
