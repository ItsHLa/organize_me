import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';

class MyAlarm {
  static void showBillNotificationInterval({
    required int id,
    required dynamic Function(int) callback,
  }) async {
    var currentDay = DateTime.now();
    await AndroidAlarmManager.periodic(const Duration(days: 2), id, callback,
        exact: true,
        allowWhileIdle: true,
        wakeup: true,
        rescheduleOnReboot: true,
        startAt: currentDay);
  }

  static void showMedicineNotificationInterval(
      {required Duration interval,
      required int id,
      required String name,
      required dynamic Function(int) callback,
      required TimeOfDay startTime}) async {
    var currentDay = DateTime.now();
    await AndroidAlarmManager.periodic(interval, id, callback,
        allowWhileIdle: true,
        wakeup: true,
        exact: true,
        rescheduleOnReboot: true,
        startAt: DateTime(currentDay.year, currentDay.month, currentDay.day,
            startTime.hour, startTime.minute));
  }

  void cancelNotification(int id) {
    AndroidAlarmManager.cancel(id);
  }
}
