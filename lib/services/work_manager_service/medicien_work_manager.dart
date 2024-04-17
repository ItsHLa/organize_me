import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';

class MedicineAlarm {
  static void showMedicineNotificationInterval(
      {required Duration interval,
      required int id,
      required Function callback,
      required TimeOfDay startTime}) async {
    var currentDay = DateTime.now();
    await AndroidAlarmManager.periodic(
      interval,
      id,
      callback,
      startAt: DateTime(currentDay.year, currentDay.month, currentDay.day,
          startTime.hour, startTime.minute),
      exact: true,
      allowWhileIdle: true,
      // wakeup: true,
    );
  }

  void cancelMedicineNotification(int id) {
    AndroidAlarmManager.cancel(id);
  }
}
