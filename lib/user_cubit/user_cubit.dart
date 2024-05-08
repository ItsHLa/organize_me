import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../services/api_calls.dart';
import '../user.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  /*
  Future<void> loadUserInfo() async {
    Map<String, String> info = await User.userInfo();
    emit(
      UserInfoLoaded(
        username: info['username']!,
        email: info['email']!,
      ),
    );
  }

 * */

  void login(String email, String password) async {
    emit(Loading());
    http.Response r = await ApiCalls.login(email, password);
    print(r);
    if (r.statusCode == 200) {
      //  print(r.body.);
      User.setUserInfo(
          username: 'user', //r.body['user']
          email: email,
          password: password);
      emit(Success());
    } else {
      print('failed');
      emit(Failed());
    }
  }

  void register(User user) async {
    emit(Loading());
    http.Response response = await ApiCalls.addUser(user);
    print(response);
    if (response.statusCode == 200) {
      //  print(response.body.);
      User.setUserInfo(
          username: user.username, //response.body['user']
          email: user.email,
          password: user.password);
      emit(Success());
    } else {
      print('failed');
      emit(Failed());
    }
  }
}
