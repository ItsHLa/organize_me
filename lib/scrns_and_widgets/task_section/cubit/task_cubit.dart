import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/constants.dart';
import 'package:organize_me/scrns_and_widgets/task_section/models/task.dart';
import 'package:organize_me/services/app_notification.dart';

import '../../../services/local_notification.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  List<Task> tasks = [];
  bool lastActionDelete = false;

  TaskCubit() : super(const TaskInitial(tasks: []));

  void addTask({
    required String title,
    required String status,
    required String content,
    required DateTime startDate,
    required TimeOfDay startTime,
    required int preAlarm,
  }) async {
    try {
      Map task = await Task.addTask(
        title: title,
        content: content,
        preAlarm: preAlarm,
        startTime: '${startTime.hour}:${startTime.minute}',
        startDate: '${startDate.day}/${startDate.month}/${startDate.year}',
      );
      tasks.add(Task.fromMap(task));
      AppNotification.showTaskNotificationBeforeXMinutes(
        id: task['id'],
        title: title,
        content: content,
        taskTime: startTime,
        dateTime: startDate,
        min: preAlarm,
      );
      emit(AddTaskSuccess(tasks: tasks));
    } catch (e) {
      emit(AddTaskFailed('تعذر اضافة المهمة', tasks: tasks));
    }
  }

  void deleteTask(int id) async {
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

  void editTask({
    required int id,
    required String title,
    required String content,
    required String status,
    required DateTime? startDate,
    required int preAlarm,
    required TimeOfDay? startTime,
  }) async {
    try {
      String newStartTime =
          startTime != null ? '${startTime.hour}:${startTime.minute}' : '';
      String newStartDate = startDate != null
          ? '${startDate.day}/${startDate.month}/${startDate.year}'
          : '';
      Map newTaskMap = await Task.editTask(
        id,
        newContent: content,
        newTitle: title,
        newPreAlarm: preAlarm,
        newStartTime: newStartTime,
        newStartDate: newStartDate,
      );
      int i = tasks.indexOf(tasks.singleWhere((task) => task.id == id));
      Task newTask = Task.fromMap(newTaskMap);
      tasks[i] = newTask;
      TimeOfDay taskStartTime = TimeOfDay(
        hour: int.parse(newTask.startTime.split(':')[0]),
        minute: int.parse(newTask.startTime.split(':')[1]),
      );
      DateTime taskStartDate = DateTime(
        int.parse(newTask.startDate.split('/')[2]),
        int.parse(newTask.startDate.split('/')[1]),
        int.parse(newTask.startDate.split('/')[0]),
      );
      AppNotification.showTaskNotificationBeforeXMinutes(
          id: id,
          title: newTask.title,
          content: newTask.content,
          taskTime: startTime ?? taskStartTime,
          dateTime: taskStartDate,
          min: preAlarm);
      emit(AddTaskSuccess(tasks: tasks));
    } catch (e) {
      emit(AddTaskFailed('تعذر تعديل المهمة', tasks: tasks));
    }
  }

  void loadTasks(DateTime currentDate) async {
    emit(const LoadingTasks(tasks: []));
    String date = '${currentDate.day}/${currentDate.month}/${currentDate.year}';
    try {
      await Task.getTasksByDate(date).then(
        (value) {
          tasks = value;
        },
      );
      emit(TaskLoaded(tasks: tasks));
    } catch (e) {
      //emit(const LoadingTasks(tasks: []));
    }
  }
}
