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
    required id,
    required username,
    required email,
    required password,
  }) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt('id', id);
    preferences.setString('username', username);
    preferences.setString('email', email);
    preferences.setString('password', password);
  }

  static Future<void> signUser(bool sign) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('sign', sign);
  }

  static Future<Map<String, dynamic>> userInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, dynamic> userInfo = {
      'username': preferences.getString('username')!,
      'email': preferences.getString('email')!,
      'password': preferences.getString('password')!,
      'id': preferences.getInt('id')!,
    };
    return userInfo;
  }
}
