import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

showToast(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.deepOrange[400],
    fontSize: 18.sp,
    textColor: Colors.white,
    toastLength: Toast.LENGTH_LONG,
  );
}
