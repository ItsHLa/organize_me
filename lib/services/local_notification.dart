import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tzl;
import 'package:timezone/timezone.dart' as tz;

import '../../constants.dart';

class LocalNotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void onTap(NotificationResponse notificationResponse) {}

  static Future initi() async {
    InitializationSettings initializationSettings =
        const InitializationSettings(
            android: AndroidInitializationSettings('@mipmap/ic_launcher'),
            iOS: DarwinInitializationSettings());
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onTap,
        onDidReceiveBackgroundNotificationResponse: onTap);
  }

  static cancelNotification({required int id, required String tag}) {
    flutterLocalNotificationsPlugin.cancel(id, tag: tag);
  }

  static void showSimpleBillNotification(
      {required int id, required String body}) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      billChannel,
      billChannelName,
      tag: billTag,
      importance: Importance.max,
      priority: Priority.high,
    );
    NotificationDetails details =
        NotificationDetails(android: androidNotificationDetails);
    await LocalNotificationService.flutterLocalNotificationsPlugin.show(
      id,
      'Organize Me',
      body,
      details,
    );
  }

  static void showMedicineNotification({
    required int id,
    required String name,
  }) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      medicineChannel,
      medicineChannelName,
      tag: medicineTag,
      importance: Importance.max,
      priority: Priority.high,
    );
    NotificationDetails details = NotificationDetails(
      android: androidNotificationDetails,
    );

    await LocalNotificationService.flutterLocalNotificationsPlugin.show(
      id,
      name,
      'لا تنسى أخذ دوائك',
      details,
    );
  }

  static void showTaskNotification({
    required int id,
    required DateTime dateTime,
    required TimeOfDay taskTime,
    required String title,
    required String content,
    required int min,
  }) async {
    AndroidNotificationDetails androidTaskSettings =
        const AndroidNotificationDetails(
      taskChannel,
      taskChannelName,
      tag: taskTag,
      importance: Importance.max,
      priority: Priority.high,
    );
    NotificationDetails taskDetails =
        NotificationDetails(android: androidTaskSettings);
    tzl.initializeTimeZones();
    String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
    var currentTime = tz.TZDateTime.now(tz.local);
    var scheduledTime = tz.TZDateTime(
      tz.local,
      dateTime.year,
      dateTime.month,
      dateTime.day,
      taskTime.hour,
      taskTime.minute,
    );
    if (scheduledTime.isAfter(currentTime)) {
      await LocalNotificationService.flutterLocalNotificationsPlugin
          .zonedSchedule(
        id,
        title,
        content,
        scheduledTime.subtract(Duration(minutes: min)),
        taskDetails,
        payload: ' Title : $title , Content : $content',
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }
}

/*
* static void showBillMonthlyNotification() async {
    AndroidNotificationDetails billsAndroidNotificationDetails =
        const AndroidNotificationDetails('bills_channel', 'Bills',
            importance: Importance.max, priority: Priority.high);
    NotificationDetails billsdetails =
        NotificationDetails(android: billsAndroidNotificationDetails);
    tz.initializeTimeZones();
    tz.setLocalLocation(
        tz.getLocation(await FlutterTimezone.getLocalTimezone()));
    var currentTime = tz.TZDateTime.now(tz.local); // getting the current time
    // setting our scheduled time  getting  a notification every week on 12:00
    var scheduledTime = tz.TZDateTime(
        tz.local, currentTime.year, currentTime.month, currentTime.day, 12, 0);
    // comparing our current time with scheduled
    // in case our scheduled time
    // is not compatabile with current time
    // the notification will not be sent
    // so we compare them and add the valid time
    // for example we added our notification in 13 / 4
    // and we want after week to get the same notification
    // the valid date should be 20 / 4
    // but the notification is set on 13 / 4 it wont be sent( the date should be in future)
    // so we added 7 days
    // everytime the work manager triggers it will add the 7 days
    if (scheduledTime.isBefore(currentTime)) {
      scheduledTime = scheduledTime.add(const Duration(days: 1));
    }
    await LocalNotificationService.flutterLocalNotificationsPlugin
        .zonedSchedule(
      2,
      'Organize Me',
      ' لا تنسى دفع فواتيرك الشهرية ',
      tz.TZDateTime(
        tz.local,
        currentTime.year,
        currentTime.month,
        currentTime.day,
        12,
        0,
      ),
      billsdetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
*
* */
