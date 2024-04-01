part of 'add_task_cubit.dart';

@immutable
sealed class TaskState {}

final class TaskInitial extends TaskState {}

final class AddTaskLoading extends TaskState {}

final class AddTaskSucsses extends TaskState {}

final class AddTaskFaild extends TaskState {

  String? msg ;
  AddTaskFaild( {required this.msg});

}
