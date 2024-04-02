part of 'add_task_cubit.dart';

@immutable
sealed class DateState {}

final class DateInitial extends DateState {}

final class AddDateLoading extends DateState {}

final class AddDateSucsses extends DateState {}

final class AddDateFaild extends DateState {
  String? msg;

  AddDateFaild({required this.msg});
}
