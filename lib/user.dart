import 'package:shared_preferences/shared_preferences.dart';

class User {
  final String userName;

  final String email;

  final String password;

  User({required this.userName, required this.email, required this.password}) {
    setUserInfo(userName: userName, email: email, password: password);
  }

  Future<void> setUserInfo(
      {required userName, required email, required password}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('userName', userName);
    preferences.setString('email', email);
    preferences.setString('password', password);
  }
}
