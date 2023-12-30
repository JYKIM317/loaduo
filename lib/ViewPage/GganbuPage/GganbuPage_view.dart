import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class GganbuPage extends ConsumerWidget {
  const GganbuPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.only(top: 44.h),
      child: Padding(
        padding: EdgeInsets.only(top: 44.h),
        child: SizedBox(),
      ),
    );
  }
}
