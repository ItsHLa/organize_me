part of 'task_cubit.dart';

@immutable
sealed class TaskState {
  final List tasks;

  const TaskState({required this.tasks});
}

final class TaskInitial extends TaskState {
  const TaskInitial({required super.tasks});
}

final class AddTaskSuccess extends TaskState {
  const AddTaskSuccess({required super.tasks});
}

final class DeleteTaskSuccess extends TaskState {
  const DeleteTaskSuccess({required super.tasks});
}

final class AddTaskFailed extends TaskState {
  final String msg;

  const AddTaskFailed(this.msg, {required super.tasks});
}

final class DeleteTaskFailed extends TaskState {
  final String msg;

  const DeleteTaskFailed(this.msg, {required super.tasks});
}

final class LoadingTasks extends TaskState {
  const LoadingTasks({required super.tasks});
}

final class TaskLoaded extends TaskState {
  const TaskLoaded({required super.tasks});
}
