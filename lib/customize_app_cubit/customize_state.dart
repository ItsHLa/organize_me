part of 'customize_cubit.dart';

@immutable
sealed class CustomizeState {
  final bool taskNotes;
  final bool bill;
  final bool numMeds;
  final bool darkMode;

  const CustomizeState(
      {required this.taskNotes,
      required this.bill,
      required this.numMeds,
      required this.darkMode});
}

final class CustomizeInitial extends CustomizeState {
  const CustomizeInitial(
      {required super.taskNotes,
      required super.bill,
      required super.numMeds,
      required super.darkMode});
}

final class CustomizeBottomNavigationBar extends CustomizeState {
  const CustomizeBottomNavigationBar(
      {required super.darkMode,
      required super.taskNotes,
      required super.bill,
      required super.numMeds});
}

final class CustomizeBottomNavigationBarFailed extends CustomizeState {
  final String msg;

  const CustomizeBottomNavigationBarFailed(
      {required this.msg,
      required super.taskNotes,
      required super.bill,
      required super.numMeds,
      required super.darkMode});
}

final class CustomizeDarkModeOn extends CustomizeState {
  const CustomizeDarkModeOn({
    required super.taskNotes,
    required super.bill,
    required super.numMeds,
    required super.darkMode,
  });
}

final class CustomizeDarkModeOff extends CustomizeState {
  const CustomizeDarkModeOff({
    required super.taskNotes,
    required super.bill,
    required super.numMeds,
    required super.darkMode,
  });
}
