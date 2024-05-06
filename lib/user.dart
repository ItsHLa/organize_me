import 'package:shared_preferences/shared_preferences.dart';

class User {
  final String email;
  final String password;
  final String username;
  const User({
    required this.email,
    required this.password,
    required this.username,
  });
  static Future<void> setUserInfo({
    required username,
    required email,
    required password,
  }) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('username', username);
    preferences.setString('email', email);
    preferences.setString('password', password);
  }

  static Future<Map<String, String>> userInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, String> userInfo = {
      'username': preferences.getString('username')!,
      'email': preferences.getString('email')!,
      'password': preferences.getString('password')!
    };
    return userInfo;
  }
}
