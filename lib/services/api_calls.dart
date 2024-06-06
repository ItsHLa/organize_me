import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:organize_me/user.dart';

import '../scrns_and_widgets/bill_section/models/bill.dart';

class ApiCalls {
  static String baseUrl = "http://haidaraib.pythonanywhere.com";

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

  static Future<Response> editUserInfo(
      {required int id,
      required String userName,
      required String email,
      required String password}) async {
    var url = Uri.parse("$baseUrl/updateUserInfo/");
    var r = await http.post(url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'id': id,
          "email": email,
          'password': password,
          'username': userName
        }));
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

  static Future<http.Response> addBills(
    int userId,
    String type,
    bills,
  ) async {
    List<Map> bodyList = [];
    if (bills is Map) {
      bills['user'] = userId.toString();
      bodyList.add(bills);
    } else {
      for (Bill bill in bills) {
        Map body = bill.toJson();
        body['user'] = userId.toString();
        bodyList.add(body);
      }
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
