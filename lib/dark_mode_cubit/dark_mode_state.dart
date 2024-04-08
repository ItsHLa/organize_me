part of 'dark_mode_cubit.dart';

@immutable
sealed class DarkModeState {
  final Icon icon;

  const DarkModeState(this.icon);
}

final class DarkModeInitial extends DarkModeState {
  const DarkModeInitial(super.icon);
}

final class DarkModeOn extends DarkModeState {
  const DarkModeOn(super.icon);
}

final class DarkModeOff extends DarkModeState {
  const DarkModeOff(super.icon);
}
