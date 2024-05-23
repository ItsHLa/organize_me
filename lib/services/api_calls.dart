import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:organize_me/constants.dart';
import 'package:organize_me/user.dart';

import '../scrns_and_widgets/bill_section/models/bill.dart';

class ApiCalls {
  static String baseUrl = "http://haidaraib.pythonanywhere.com";

  static Future<http.Response> updateUserInfo() async {
    var r = await http.post(
      Uri.parse("$baseUrl/updateUserInfo/"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        {
          "id": me.id,
          "email": me.email,
          "password": me.password,
          "username": me.username,
          "last_el_bill": me.lastElBill,
          "last_wa_bill": me.lastWaBill,
          "last_tel_bill": me.lastTelBill,
        },
      ),
    );
    return r;
  }

  static Future<http.Response> addUser(User user) async {
    var r = await http.post(
      Uri.parse("$baseUrl/addUser/"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        {
          "email": user.email,
          "password": user.password,
          "username": user.username,
        },
      ),
    );
    return r;
  }

  static Future<http.Response> login(String email, String password) async {
    var r = await http.post(
      Uri.parse("$baseUrl/login/"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        {
          "email": email,
          "password": password,
        },
      ),
    );
    return r;
  }

  static Future<http.Response> getBills(int userId, String type) async {
    var r = await http.get(
      Uri.parse("$baseUrl/getBills/$type/$userId/"),
    );
    return r;
  }

  static Future<http.Response> getUser(int userId) async {
    var r = await http.get(
      Uri.parse("$baseUrl/getUser/$userId/"),
    );
    return r;
  }

  static Future<http.Response> addBill(
    int userId,
    String type,
    Bill bill,
  ) async {
    Map<String, String> body = bill.toJson();
    body['user'] = userId.toString();
    var r = await http.post(
      Uri.parse("$baseUrl/addBill/$type/"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(body),
    );
    return r;
  }

  static Future<http.Response> addBills(
    int userId,
    String type,
    List<Bill> bills,
  ) async {
    List<Map<String, String>> bodyList = [];
    for (Bill bill in bills) {
      Map<String, String> body = bill.toJson();
      body['user'] = userId.toString();
      bodyList.add(body);
    }
    var r = await http.post(
      Uri.parse("$baseUrl/addBills/$type/"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(bodyList),
    );
    return r;
  }
}
