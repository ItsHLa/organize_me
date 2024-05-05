import 'package:http/http.dart' as http;
import 'package:organize_me/user.dart';
import 'package:organize_me/constants.dart';

Future<http.Response> addUser(User user) async {
  var r = await http.post(
    Uri.parse("$baseUrl/addUser/"),
    body: {
      "email": user.email,
      "password": user.password,
      "username": user.username,
    },
  );
  return r;
}

Future<http.Response> getBills(int userId, String type) async {
  var r = await http.get(
    Uri.parse("$baseUrl/getBills/$type/$userId/"),
  );
  return r;
}
