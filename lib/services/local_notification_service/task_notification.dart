import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'local_notification.dart';

class TaskNotification extends LocalNotificationService {
  static void showTaskNotificationBefore15minutes({
    required int id,
    required DateTime dateTime,
    required TimeOfDay taskTime,
    required String title,
    required String content,
  }) async {
    // setting up Task Channel or notification settings for android
    AndroidNotificationDetails androidTaskSettings =
        const AndroidNotificationDetails(
      'task_channel', 'Tasks',
      // to make notification shows in notification bar ( alsetara I don't know what its called)
      importance: Importance.max,
      priority: Priority.high,
    );
    NotificationDetails taskDetails =
        NotificationDetails(android: androidTaskSettings);
    // setting up time to user time zone
    tz.initializeTimeZones();
    String currenTimeZone =
        await FlutterTimezone.getLocalTimezone(); // getting user location
    tz.setLocalLocation(tz.getLocation(currenTimeZone));
    // the function that calls notification
    var currentTime = tz.TZDateTime.now(tz.local);
    log('currentTime  ${currentTime.hour} : ${currentTime.minute}');

    var scheduledTime = tz.TZDateTime(
        tz.local, // location
        // task time and date
        dateTime.year,
        dateTime.month,
        dateTime.day,
        taskTime.hour,
        taskTime.minute);
//    log('scheduledTime  ${scheduledTime.hour} : ${scheduledTime.minute}');

    //log('before  ${scheduledTime.isBefore(currentTime)}');
    //log('before  ${scheduledTime.isAtSameMomentAs(currentTime)}');
    //log('aftr  ${scheduledTime.isAfter(currentTime)}');
    //log('same  ${scheduledTime.hour == currentTime.hour && scheduledTime.minute == currentTime.minute}');

    if (scheduledTime.isAfter(currentTime)) {
      // before 30 minutes
      await LocalNotificationService.flutterLocalNotificationsPlugin
          .zonedSchedule(id, title, content,
              scheduledTime.subtract(const Duration(minutes: 30)), taskDetails,
              payload: ' Title : $title , Content : $content',
              uiLocalNotificationDateInterpretation:
                  UILocalNotificationDateInterpretation.absoluteTime);
    }
    //else if(scheduledTime.hour == currentTime.hour && scheduledTime.minute == currentTime.minute){
    //LocalNotificationService.flutterLocalNotificationsPlugin.show(
    //  id,
    //title,
    // content,
    // taskDetails);
    // }
  }

  static void showTaskNotificationBefore1hour({
    required int id,
    required DateTime dateTime,
    required TimeOfDay taskTime,
    required String title,
    required String content,
  }) async {
    AndroidNotificationDetails details = const AndroidNotificationDetails(
        'task_channel', 'Tasks',
        importance: Importance.max, priority: Priority.high);
    NotificationDetails notificationDetails =
        NotificationDetails(android: details);
    tz.initializeTimeZones();
    tz.setLocalLocation(
        tz.getLocation(await FlutterTimezone.getLocalTimezone()));
    var scheduledTime = tz.TZDateTime(tz.local, dateTime.year, dateTime.month,
        dateTime.day, dateTime.hour, dateTime.minute);
    var currentTime = tz.TZDateTime.now(tz.local);
    if (scheduledTime.isAfter(currentTime)) {
      await LocalNotificationService.flutterLocalNotificationsPlugin
          .zonedSchedule(
              id,
              title,
              content,
              scheduledTime.subtract(const Duration(hours: 1)),
              notificationDetails,
              uiLocalNotificationDateInterpretation:
                  UILocalNotificationDateInterpretation.absoluteTime);
    }
  }

  static void cancelTaskNotification(int taskId) {
    LocalNotificationService.flutterLocalNotificationsPlugin.cancel(taskId);
  }
}
