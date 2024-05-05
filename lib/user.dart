import 'package:shared_preferences/shared_preferences.dart';

class User {
  static Future<void> setUserInfo(
      {required userName, required email, required password}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('userName', userName);
    preferences.setString('email', email);
    preferences.setString('password', password);
  }

  static Future<Map<String, String>> userInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, String> userInfo = {
      'userName': preferences.getString('userName')!,
      'email': preferences.getString('email')!,
      'password': preferences.getString('password')!
    };
    return userInfo;
  }
}
