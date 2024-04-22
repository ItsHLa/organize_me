part of 'customize_cubit.dart';

@immutable
sealed class CustomizeState {
  final bool taskNotes;

  final bool bill;

  final bool numMeds;

  const CustomizeState(
      {required this.taskNotes, required this.bill, required this.numMeds});
}

final class CustomizeInitial extends CustomizeState {
  CustomizeInitial(
      {required super.taskNotes, required super.bill, required super.numMeds});
}

final class Customize extends CustomizeState {
  Customize(
      {required super.taskNotes, required super.bill, required super.numMeds});
}
