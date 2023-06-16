import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeManager with ChangeNotifier {
  static const String _themeKey = 'theme';

  late ThemeMode _themeMode = ThemeMode.light;

  ThemeManager() {
    _loadThemeMode();
  }

  ThemeMode get themeMode => _themeMode;

  void setBrightness(Brightness brightness) async {
    _themeMode =
        brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
        _themeKey, brightness == Brightness.dark ? 'dark' : 'light');
  }

  Future<void> _loadThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String theme = prefs.getString(_themeKey) ?? 'light';
    _themeMode = theme == 'dark' ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
