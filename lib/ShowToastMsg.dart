import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

showToast(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    gravity: ToastGravity.CENTER,
    backgroundColor: Colors.grey[100],
    fontSize: 18.sp,
    textColor: Colors.deepOrange[400],
    toastLength: Toast.LENGTH_SHORT,
  );
}
