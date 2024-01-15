import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

class GuildPostView extends StatefulWidget {
  final Map<String, dynamic> post;
  const GuildPostView({super.key, required this.post});

  @override
  State<GuildPostView> createState() => _GuildPostViewState();
}

class _GuildPostViewState extends State<GuildPostView> {
  late Map<String, dynamic> post;
  String? userUID = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    post = widget.post;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
      ),
    );
  }
}
