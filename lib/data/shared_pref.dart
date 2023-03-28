
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {

  static setFcmRegId(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("FCM_REG_ID", value);
  }

  static Future<String?> getFcmRegId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("FCM_REG_ID") ?? null;
  }

}