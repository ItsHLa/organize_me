import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'local_notification.dart';

class TaskNotification extends LocalNotificationService {
  static void showTaskNotification({
    required int id,
    required DateTime dateTime,
    required TimeOfDay taskTime,
    required String title,
    required String content,
  }) async {
    // setting up Task Channel or notification settings for android
    AndroidNotificationDetails androidTaskSettings =
        const AndroidNotificationDetails('task_channel', 'Tasks',
            // to make notification shows in notification bar ( alsetara I don't know what its called)
            importance: Importance.max,
            priority: Priority.high);
    NotificationDetails taskDetails =
        NotificationDetails(android: androidTaskSettings);
    // setting up time to user time zone
    tz.initializeTimeZones();
    String currenTimeZone =
        await FlutterTimezone.getLocalTimezone(); // getting user location
    tz.setLocalLocation(tz.getLocation(currenTimeZone));
    // the function that calls notification
    await LocalNotificationService.flutterLocalNotificationsPlugin
        .zonedSchedule(
            id,
            title,
            content,
            tz.TZDateTime(
                    tz.local, // location
                    // task time and date
                    dateTime.year,
                    dateTime.month,
                    dateTime.day,
                    taskTime.hour,
                    taskTime.minute)
                // to reminde before time
                .subtract(const Duration(minutes: 10)),
            taskDetails,
            payload: ' Title : ${title} , Content : ${content}',
            uiLocalNotificationDateInterpretation:
                UILocalNotificationDateInterpretation.absoluteTime);
  }

  static void cancelTaskNotification(int taskId) {
    LocalNotificationService.flutterLocalNotificationsPlugin.cancel(taskId);
  }
}
