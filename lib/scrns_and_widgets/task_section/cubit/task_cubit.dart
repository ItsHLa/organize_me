import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/constants.dart';
import 'package:organize_me/scrns_and_widgets/task_section/models/task.dart';
import 'package:organize_me/services/app_notification.dart';

import '../../../services/local_notification.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  List<Task> tasks = [];

  TaskCubit() : super(const TaskInitial(tasks: []));

  void addTask(
    String title,
    String content,
    DateTime dateTime,
    TimeOfDay startTime,
    TimeOfDay endTime,
    int remindMeBefore,
  ) async {
    try {
      Map task = await Task.addTask(
        title,
        content,
        '${startTime.hour}:${startTime.minute}',
        '${endTime.hour}:${endTime.minute}',
        '${dateTime.day}/${dateTime.month}/${dateTime.year}',
      );
      tasks.add(Task.fromMap(task));
      AppNotification.showTaskNotificationBeforeXMinutes(
          id: task['id'],
          title: title,
          content: content,
          taskTime: startTime,
          dateTime: dateTime,
          min: remindMeBefore);

      emit(AddTaskSuccess(tasks: tasks));
    } catch (e) {
      emit(AddTaskFailed('تعذر اضافة المهمة', tasks: tasks));
    }
  }

  void deleteTask(int id, BuildContext context) async {
    try {
      LocalNotificationService.cancelNotification(id: id, tag: taskTag);
      await Task.deleteTask(id).then(
        (_) {
          tasks.remove(tasks.singleWhere((task) => task.id == id));
        },
      );

      emit(DeleteTaskSuccess(tasks: tasks));
    } catch (e) {
      emit(DeleteTaskFailed('تعذر حذف المهمة', tasks: tasks));
    }
  }

  void editTask(
      {required int id,
      required String title,
      required String content,
      required DateTime dateTime,
      required TimeOfDay startTime,
      required TimeOfDay endTime,
      required int remindMeBefore}) async {
    try {
      AppNotification.showTaskNotificationBeforeXMinutes(
          id: id,
          title: title,
          content: content,
          taskTime: startTime,
          dateTime: dateTime,
          min: remindMeBefore);
      await Task.editTask(id,
              newContent: content,
              newTitle: title,
              newEndTime: '${endTime.hour}:${endTime.minute}',
              newStartTime: '${startTime.hour}:${startTime.minute}',
              newStartDate:
                  '${dateTime.day}/${dateTime.month}/${dateTime.year}')
          .then(
        (newTask) {
          int i = tasks.indexOf(tasks.singleWhere((task) => task.id == id));
          tasks[i] = Task.fromMap(newTask);
        },
      );

      emit(AddTaskSuccess(tasks: tasks));
    } catch (e) {
      emit(AddTaskFailed('تعذر تعديل المهمة', tasks: tasks));
    }
  }

  void loadTasks(DateTime currentDate) async {
    String date = '${currentDate.day}/${currentDate.month}/${currentDate.year}';
    emit(const LoadingTasks(tasks: []));
    try {
      await Task.getTasksByDate(date).then(
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
