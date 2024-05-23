import 'package:shared_preferences/shared_preferences.dart';

class User {
  final int id;
  final String email;
  final String password;
  final String username;
  final int lastElBill;
  final int lastTelBill;
  final int lastWaBill;
  const User({
    this.id = 0,
    required this.email,
    required this.password,
    required this.username,
    this.lastElBill = 0,
    this.lastWaBill = 0,
    this.lastTelBill = 0,
  });
  static Future<void> setUserInfo({
    required id,
    required username,
    required email,
    required password,
    required lastElBill,
    required lastWaBill,
    required lastTelBill,
  }) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt('id', id);
    preferences.setString('username', username);
    preferences.setString('email', email);
    preferences.setString('password', password);
    preferences.setString('last_el_bill', lastElBill);
    preferences.setString('last_wa_bill', lastWaBill);
    preferences.setString('last_tel_bill', lastTelBill);
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
      'last_el_bill': preferences.getInt('last_el_bill')!,
      'last_wa_bill': preferences.getInt('last_wa_bill')!,
      'last_tel_bill': preferences.getInt('last_tel_bill')!,
    };
    return userInfo;
  }

  @override
  String toString() {
    return "User($id, $email, $password, $username,)";
  }
}
