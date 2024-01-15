import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

class GganbuPostView extends StatefulWidget {
  final Map<String, dynamic> post;
  const GganbuPostView({super.key, required this.post});

  @override
  State<GganbuPostView> createState() => _GganbuPostViewState();
}

class _GganbuPostViewState extends State<GganbuPostView> {
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
        color: Colors.white,
      ),
    );
  }
}
