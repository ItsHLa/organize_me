import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'dark_mode_state.dart';

class DarkModeCubit extends Cubit<DarkModeState> {
  DarkModeCubit() : super(const DarkModeInitial(false));

  void darkModeIsOn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool darKMode = prefs.getBool('darkMode')!;
    darKMode = !darKMode;
    prefs.setBool('darkMode', darKMode);
    emit(DarkModeOn(darKMode));
  }

  void getDarkMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkMode', prefs.getBool('darkMode') ?? false);
    emit(DarkModeOn(prefs.getBool('darkMode')!));
  }
}
