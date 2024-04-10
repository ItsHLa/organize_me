import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/task_section/models/task.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  List<Task> tasks = [];
  TaskCubit() : super(const TaskInitial(tasks: []));

  void addTask(
    String title,
    String tag,
    String content,
    String startTime,
    String endTime,
  ) async {
    try {
      Map task = await Task.addTask(title, content, tag, startTime, endTime);
      tasks.add(Task.fromMap(task));
      // schedule the task
      emit(AddTaskSuccess(tasks: tasks));
    } catch (e) {
      emit(const AddTaskFailed('تعذر اضافة المهمة', tasks: []));
    }
  }

  void deleteTask(int id) {
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

  void loadTasks() async {
    emit(const LoadingTasks(tasks: []));
    try {
      await Task.getAllTasks().then(
        (value) {
          tasks = value;
          emit(TaskLoaded(tasks: tasks));
        },
      );
    } catch (e) {
      emit(const LoadingTasks(tasks: []));
    }
  }
}
