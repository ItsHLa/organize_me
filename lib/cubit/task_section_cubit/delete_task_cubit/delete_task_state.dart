part of 'delete_task_cubit.dart';

@immutable
sealed class DeleteTaskState {}

final class DeleteTaskInitial extends DeleteTaskState {}

final class DeleteTaskLoading extends DeleteTaskState {}

final class DeleteTaskSucsses extends DeleteTaskState {}

final class DeleteTaskFaild extends DeleteTaskState {

  String? msg ;
  DeleteTaskFaild( {required this.msg});

}