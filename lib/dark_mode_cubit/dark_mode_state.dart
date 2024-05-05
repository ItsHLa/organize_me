part of 'dark_mode_cubit.dart';

@immutable
sealed class DarkModeState {
  final bool on;

  const DarkModeState(this.on);
}

final class DarkModeInitial extends DarkModeState {
  const DarkModeInitial(super.on);
}

final class DarkModeOn extends DarkModeState {
  const DarkModeOn(super.on);
}
