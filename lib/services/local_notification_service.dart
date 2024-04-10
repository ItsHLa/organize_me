import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../scrns_and_widgets/task_section/models/task.dart';

class LocalNotificationService {
  //SetUp
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static onTap(NotificationResponse notificationResponse) {}

  static Future inite() async {
    InitializationSettings settings = const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveBackgroundNotificationResponse: onTap,
      onDidReceiveNotificationResponse: onTap,
    );
  }

  // for canceling Notification
  static cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  // scheduled Notification
  static void showScheduledTaskNotification(
      {required DateTime currentDate,
      required TimeOfDay startTime,
      required TimeOfDay reminder,
      required Task task}) async {
    AndroidNotificationDetails android = const AndroidNotificationDetails(
        'id 1 ', 'scheduled Notification',
        importance: Importance.max, priority: Priority.high);
    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
    NotificationDetails details = NotificationDetails(android: android);
    await flutterLocalNotificationsPlugin.zonedSchedule(
        task.id, // each notification should have a un
        task.title,
        task.content,
        tz.TZDateTime(tz.local, currentDate.year, currentDate.month,
                currentDate.day, startTime.hour, startTime.minute)
            .subtract(Duration(minutes: reminder.minute)),
        details,
        payload: ' Title : ${task.title} , Content : ${task.content}',
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }
}
