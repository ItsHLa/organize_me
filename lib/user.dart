import 'package:shared_preferences/shared_preferences.dart';

class User {
  final int id;
  final String email;
  final String password;
  final String username;
  const User({
    this.id = 0,
    required this.email,
    required this.password,
    required this.username,
  });
  static Future<void> setUserInfo({required Map user}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt('id', user['id']);
    preferences.setString('username', user['username']);
    preferences.setString('email', user['email']);
    preferences.setString('password', user['password']);
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

  @override
  String toString() {
    return "User($id, $email, $password, $username,)";
  }
}
