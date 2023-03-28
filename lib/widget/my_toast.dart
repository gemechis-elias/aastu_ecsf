import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyToast {
  static const Toast LENGTH_SHORT = Toast.LENGTH_SHORT;
  static const Toast LENGTH_LONG = Toast.LENGTH_LONG;

  static void show(String msg, BuildContext context,
      {Toast? duration,
      ToastGravity? gravity,
      Color? backgroundColor,
      Color? textColor,
      double? fontSize}) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: duration,
        gravity: gravity,
        backgroundColor: backgroundColor,
        textColor: textColor,
        fontSize: fontSize);
  }

  static void cancel() {
    Fluttertoast.cancel();
  }

  static FToast showCustom(BuildContext context, Widget toast,
    {
      Duration duration = const Duration(seconds: 2),
      ToastGravity gravity = ToastGravity.BOTTOM
    }) {

    FToast fToast = FToast();
    fToast.init(context);
    fToast.showToast(
        child: toast, gravity: gravity, toastDuration: duration
    );
    return fToast;
  }
}
