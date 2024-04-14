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
    String content,
    String startTime,
    String endTime,
  ) async {
    try {
      Map task = await Task.addTask(
        title,
        content,
        startTime,
        endTime,
      );
      tasks.add(Task.fromMap(task));
      // schedule the task
      emit(AddTaskSuccess(tasks: tasks));
    } catch (e) {
      emit(AddTaskFailed('تعذر اضافة المهمة', tasks: tasks));
    }
  }

  void deleteTask(int id) async {
    try {
      await Task.deleteTask(id).then(
        (_) {
          tasks.remove(tasks.singleWhere((task) => task.id == id));
        },
      );
      // cancel scheduling the task
      emit(DeleteTaskSuccess(tasks: tasks));
    } catch (e) {
      emit(DeleteTaskFailed('تعذر حذف المهمة', tasks: tasks));
    }
  }

  void editTask(
    id,
    title,
    content,
    startTime,
    endTime,
  ) async {
    try {
      await Task.editTask(
        id,
        newContent: content,
        newTitle: title,
        newEndTime: endTime,
        newStartTime: startTime,
      ).then(
        (newTask) {
          int i = tasks.indexOf(tasks.singleWhere((task) => task.id == id));
          tasks[i] = Task.fromMap(newTask);
        },
      );
      // reschedule the task
      emit(AddTaskSuccess(tasks: tasks));
    } catch (e) {
      emit(AddTaskFailed('تعذر تعديل المهمة', tasks: tasks));
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
      emit(LoadingTasks(tasks: tasks));
    }
  }
}
