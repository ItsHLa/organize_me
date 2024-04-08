part of 'dark_mode_cubit.dart';

@immutable
sealed class DarkModeState {
  final Icon icon;

  DarkModeState(this.icon);
}

final class DarkModeInitial extends DarkModeState {
  DarkModeInitial(super.icon);
}

final class DarkModeOn extends DarkModeState {
  DarkModeOn(super.icon);
}

final class DarkModeOff extends DarkModeState {
  DarkModeOff(super.icon);
}
