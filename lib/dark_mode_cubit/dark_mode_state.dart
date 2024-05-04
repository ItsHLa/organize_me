part of 'dark_mode_cubit.dart';

@immutable
sealed class DarkModeState {
  final bool On;

  DarkModeState(this.On);
}

final class DarkModeInitial extends DarkModeState {
  DarkModeInitial(super.On);
}

final class DarkModeOn extends DarkModeState {
  DarkModeOn(super.On);
}
