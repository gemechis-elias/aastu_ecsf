
import 'package:flutter/material.dart';

class MyText{

  static TextStyle? display4(BuildContext context){
    return Theme.of(context).textTheme.headline1;
  }

  static TextStyle? display3(BuildContext context){
    return Theme.of(context).textTheme.headline2;
  }

  static TextStyle? display2(BuildContext context){
    return Theme.of(context).textTheme.headline3;
  }

  static TextStyle? display1(BuildContext context){
    return Theme.of(context).textTheme.headline4;
  }

  static TextStyle? headline(BuildContext context){
    return Theme.of(context).textTheme.headline5;
  }

  static TextStyle? title(BuildContext context){
    return Theme.of(context).textTheme.headline6;
  }

  static TextStyle medium(BuildContext context){
    return Theme.of(context).textTheme.subtitle1!.copyWith(
      fontSize: 18,
    );
  }

  static TextStyle? subhead(BuildContext context){
    return Theme.of(context).textTheme.subtitle1;
  }

  static TextStyle? body2(BuildContext context){
    return Theme.of(context).textTheme.bodyText1;
  }

  static TextStyle? body1(BuildContext context){
    return Theme.of(context).textTheme.bodyText2;
  }

  static TextStyle? caption(BuildContext context){
    return Theme.of(context).textTheme.caption;
  }

  static TextStyle? button(BuildContext context){
    return Theme.of(context).textTheme.button!.copyWith(
        letterSpacing: 1
    );
  }

  static TextStyle? subtitle(BuildContext context){
    return Theme.of(context).textTheme.subtitle2;
  }

  static TextStyle? overline(BuildContext context){
    return Theme.of(context).textTheme.overline;
  }
}