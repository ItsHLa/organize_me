import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:organize_me/constants.dart';

part 'dark_mode_state.dart';

class DarkModeCubit extends Cubit<DarkModeState> {
  DarkModeCubit() : super(DarkModeInitial(darkModeOff));

  bool darkMode = false;

  void darkModeIsOn() {
    darkMode = !darkMode;
    if (darkMode) {
      emit(DarkModeOn(darkModeOn));
    } else {
      emit(DarkModeOff(darkModeOff));
    }
  }
}
