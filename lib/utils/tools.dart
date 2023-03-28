import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class Tools {
  static void setStatusBarColor(Color color) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: color));
  }

  static String allCaps(String str) {
    if(str.isNotEmpty){
      return str.toUpperCase();
    }
    return str;
  }

  static String getFormattedDateShort(int time) {
    DateFormat newFormat = new DateFormat("MMM dd, yyyy");
    return newFormat.format(new DateTime.fromMillisecondsSinceEpoch(time));
  }

  static String getFormattedDateSimple(int time) {
    DateFormat newFormat = new DateFormat("MMMM dd, yyyy");
    return newFormat.format(new DateTime.fromMillisecondsSinceEpoch(time));
  }

  static String getFormattedDateEvent(int time) {
    DateFormat newFormat = new DateFormat("EEE, MMM dd yyyy");
    return newFormat.format(new DateTime.fromMillisecondsSinceEpoch(time));
  }

  static String getFormattedTimeEvent(int time) {
    DateFormat newFormat = new DateFormat("h:mm a");
    return newFormat.format(new DateTime.fromMillisecondsSinceEpoch(time));
  }
  static String getFormattedCardNo(String cardNo){
    if(cardNo.length < 5) return cardNo;
    return cardNo.replaceAllMapped(RegExp(r".{4}"), (match) => "${match.group(0)} ");
  }

  static void directUrl(String link) async {
    if (await canLaunch(link)) {
      await launch(link);
    }
  }

}
