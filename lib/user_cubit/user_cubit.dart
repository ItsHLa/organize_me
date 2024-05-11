import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:organize_me/scrns_and_widgets/bill_section/models/bill.dart';

import '../services/api_calls.dart';
import '../user.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  Future<void> loadUserInfo() async {
    try {
      Map info = {};
      await User.userInfo().then((value) => info = value);
      emit(UserInfoLoaded(
          email: info['email'],
          password: info['password'],
          username: info['username']));
    } catch (e) {}
  }

  void login(String email, String password) async {
    emit(Loading());
    try {
      http.Response r = await ApiCalls.login(email, password);
      Map bodyMap = jsonDecode(r.body);
      print(bodyMap['el']);
      if (r.statusCode == 200) {
        await User.setUserInfo(
          username: bodyMap['username'],
          email: email,
          password: password,
        );
        await Bill.fillDatabase(
          elBills: bodyMap['el'],
          waBills: bodyMap['wa'],
          telBills: bodyMap['tel'],
        );
        emit(LoginSuccess());
      } else {
        emit(LoginFailed());
      }
    } on SocketException {
      emit(NoInternet());
    }
  }

  void register(User user) async {
    emit(Loading());
   try{
     http.Response response = await ApiCalls.addUser(user);
     if (response.statusCode == 200) {
       User.setUserInfo(
         username: user.username,
         email: user.email,
         password: user.password,
       );
       emit(RegisterSuccess());
     } else {
       emit(RegisterFailed());
     }
   }on SocketException {
     emit(NoInternet());
   }

    }
  }

