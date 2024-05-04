import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'dark_mode_state.dart';

class DarkModeCubit extends Cubit<DarkModeState> {
  DarkModeCubit() : super(DarkModeInitial());

  void darkModeIsOn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool darKMode = prefs.getBool('darkMode')!;
    darKMode = !darKMode;
    prefs.setBool('darkMode', darKMode);
    emit(DarkModeOn());
  }
}
