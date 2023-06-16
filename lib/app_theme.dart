import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static Color normalText(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xffffffff)
        : const Color(0xff000000);
  }

  static Color bodyBackground(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xff1f1f1f)
        : const Color(0xffffffff);
  }

  static Color gridentBackground(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xff1f1f1f)
        : Color.fromARGB(24, 255, 255, 255);
  }

  static Color body2Background(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xff212121)
        : const Color(0xfffffff0);
  }

  static Color iconBackground(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xff808080)
        : const Color(0xff808080);
  }

  static Color activeIconBackground(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xffd1a552)
        : const Color(0xffd1a552);
  }

  static Color activeIcon2Background(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xffCA7754)
        : const Color(0xffCA7754);
  }

  static Color liveBackground(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xffE23936)
        : const Color(0xffE23936);
  }

  static Color navBackground(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xff121212)
        : const Color(0xffffffff);
  }

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    // Define other light theme properties here
    colorScheme: ColorScheme.light(
      brightness: Brightness.light,
      // Define other dark color scheme properties here
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      // Set the brightness property of the color scheme to match the theme brightness
      brightness: Brightness.dark,
      // Define other dark color scheme properties here
    ),
    // Define other dark theme properties here
  );
}
