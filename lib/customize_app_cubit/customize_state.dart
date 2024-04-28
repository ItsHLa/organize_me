part of 'customize_cubit.dart';

@immutable
sealed class CustomizeState {
  final bool taskNotes;
  final bool bill;
  final bool numMeds;
  final bool darkMode;
  final List pages;
  final List<TabItem> tabs;

  const CustomizeState({
    required this.pages,
    required this.tabs,
    required this.taskNotes,
    required this.bill,
    required this.numMeds,
    required this.darkMode,
  });
}

final class CustomizeInitial extends CustomizeState {
  const CustomizeInitial(
      {required super.taskNotes,
      required super.bill,
      required super.numMeds,
      required super.darkMode,
      required super.pages,
      required super.tabs});
}

final class Customize extends CustomizeState {
  const Customize(
      {required super.darkMode,
      required super.taskNotes,
      required super.bill,
      required super.numMeds,
      required super.pages,
      required super.tabs});
}

final class CustomizeFailed extends CustomizeState {
  final String msg;

  const CustomizeFailed(
      {required super.darkMode,
      required this.msg,
      required super.taskNotes,
      required super.bill,
      required super.numMeds,
      required super.pages,
      required super.tabs});
}
