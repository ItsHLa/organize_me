import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:organize_me/scrns_and_widgets/bill_section/models/bill.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/api_calls.dart';
import '../user.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  checkIfSigned() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool signed = preferences.getBool('sign') ?? false;
    emit(CheckIfSigned(signed));
  }

  Future<void> loadUserInfo() async {
    Map info = {};
    await User.userInfo().then((value) => info = value);
    emit(
      UserInfoLoaded(
        id: info['id'],
        email: info['email'],
        password: info['password'],
        username: info['username'],
      ),
    );
  }

  Future<void> editUserInfo(
      {required int id,
      required String userName,
      required String email,
      required String password}) async {
    var result = await Connectivity().checkConnectivity();
    if (result.contains(ConnectivityResult.wifi) ||
        result.contains(ConnectivityResult.mobile)) {
      emit(Loading());
      try {
        var r = await ApiCalls.editUserInfo(
          id: id,
          password: password,
          email: email,
          userName: userName,
        );
        if (r.statusCode == 200) {
          Map bodyMap = jsonDecode(r.body);
          bodyMap['user']['password'] = password;
          await User.setUserInfo(user: bodyMap['user']);
          emit(UserInfoEdited(
            id: id,
            email: email,
            password: password,
            username: userName,
          ));
        } else {
          emit(Failed());
        }
      } on SocketException {
        emit(NoInternet());
      }
    } else {
      emit(NoInternet());
    }
  }

  void checkInternet() async {
    var result = await (Connectivity().checkConnectivity());
    if (result.contains(ConnectivityResult.none)) {
      emit(NoInternet());
    }
  }

  void login(String email, String password) async {
    var result = await (Connectivity().checkConnectivity());
    if (result.contains(ConnectivityResult.wifi) ||
        result.contains(ConnectivityResult.mobile)) {
      emit(Loading());
      try {
        http.Response r = await ApiCalls.login(email, password);
        if (r.statusCode == 200) {
          Map bodyMap = jsonDecode(r.body);
          bodyMap['user']['password'] = password;
          await User.signUser(true);
          await User.setUserInfo(user: bodyMap['user']);
          await Bill.fillDatabase(
            elBills: bodyMap['el'],
            waBills: bodyMap['wa'],
            telBills: bodyMap['tel'],
          );
          emit(LoginSuccess());
        } else {
          await User.signUser(false);
          emit(LoginFailed());
        }
      } on SocketException {
        await User.signUser(false);
        emit(NoInternet());
      }
    }
  }

  void register(User user) async {
    var result = await (Connectivity().checkConnectivity());
    if (result.contains(ConnectivityResult.wifi) ||
        result.contains(ConnectivityResult.mobile)) {
      emit(Loading());
      try {
        http.Response response = await ApiCalls.addUser(user);
        if (response.statusCode == 200) {
          Map bodyMap = jsonDecode(response.body);
          bodyMap['me']['password'] = user.password;
          await User.signUser(true);
          await User.setUserInfo(user: bodyMap['me']);
          emit(RegisterSuccess());
        } else {
          await User.signUser(false);
          emit(RegisterFailed());
        }
      } on SocketException {
        await User.signUser(false);
        emit(NoInternet());
      }
    } else {
      emit(NoInternet());
    }
  }
}
