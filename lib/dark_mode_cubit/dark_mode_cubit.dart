import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:organize_me/constants.dart';

part 'dark_mode_state.dart';

class DarkModeCubit extends Cubit<DarkModeState> {
  DarkModeCubit() : super(const DarkModeInitial(darkModeOff));

  bool darkMode = false;

  void darkModeIsOn() {
    darkMode = !darkMode;
    if (darkMode) {
      emit(const DarkModeOn(darkModeOn));
    } else {
      emit(const DarkModeOff(darkModeOff));
    }
  }
}
