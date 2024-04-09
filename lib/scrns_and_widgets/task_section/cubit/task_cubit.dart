import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(const TaskInitial(tasks: []));

  void addTask() {
    try {
      // add to database
      // schedule the task
      emit(const AddTaskSuccess(tasks: []));
    } catch (e) {
      emit(const AddTaskFailed('تعذر اضافة المهمة', tasks: []));
    }
  }

  void deleteTask() {
    try {
      // delete
      // cancel scheduling the task
      emit(const DeleteTaskSuccess(tasks: []));
    } catch (e) {
      emit(const DeleteTaskFailed('تعذر حذف المهمة', tasks: []));
    }
  }

  void editTask() {
    try {
      // update
      // reschedule the task
      emit(const AddTaskSuccess(tasks: []));
    } catch (e) {
      emit(const AddTaskFailed('تعذر تعديل المهمة', tasks: []));
    }
  }

  void loadTasks() {
    emit(const LoadingTasks(tasks: []));
    try {
      // get  all tasks
      emit(const TaskLoaded(tasks: []));
    } catch (e) {
      emit(const LoadingTasks(tasks: []));
    }
  }
}
