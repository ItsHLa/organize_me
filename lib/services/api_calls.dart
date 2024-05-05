import 'package:requests/requests.dart';
import 'package:http/http.dart';
import 'package:organize_me/user.dart';
import 'package:organize_me/constants.dart';

Future<Response> addUser(User user) async {
  var r = await Requests.post(
    "$baseUrl/addUser/",
    body: {
      "email": user.email,
      "password": user.password,
      "username": user.username,
    },
  );
  return r;
}

Future<Response> getBills(int userId, String type) async {
  var r = await Requests.get("$baseUrl/getBills/$type/$userId/");
  return r;
}
