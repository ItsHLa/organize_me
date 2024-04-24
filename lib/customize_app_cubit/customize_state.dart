part of 'customize_cubit.dart';

@immutable
sealed class CustomizeState {
  final bool taskNotes;
  final bool bill;
  final bool numMeds;
  final bool darkMode;

  CustomizeState(
      {required this.taskNotes,
      required this.bill,
      required this.numMeds,
      required this.darkMode});
}

final class CustomizeInitial extends CustomizeState {
  CustomizeInitial(
      {required super.taskNotes,
      required super.bill,
      required super.numMeds,
      required super.darkMode});
}

final class CustomizeBottomNavigationBar extends CustomizeState {
  CustomizeBottomNavigationBar(
      {required super.darkMode,
      required super.taskNotes,
      required super.bill,
      required super.numMeds});
}

final class CustomizeBottomNavigationBarFailed extends CustomizeState {
  final String msg;

  CustomizeBottomNavigationBarFailed(
      {required this.msg,
      required super.taskNotes,
      required super.bill,
      required super.numMeds,
      required super.darkMode});
}

final class CustomizeDarkModeOn extends CustomizeState {
  CustomizeDarkModeOn({
    required super.taskNotes,
    required super.bill,
    required super.numMeds,
    required super.darkMode,
  });
}

final class CustomizeDarkModeOff extends CustomizeState {
  CustomizeDarkModeOff({
    required super.taskNotes,
    required super.bill,
    required super.numMeds,
    required super.darkMode,
  });
}
