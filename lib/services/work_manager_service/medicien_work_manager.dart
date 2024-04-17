import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class MedicineAlarm {
  //bool _status = false ;

  static askForAlarmPermission() async {
    await Permission.scheduleExactAlarm.request();
  }

  static void showBillNotificationInterval(
      {required int id,
      required dynamic Function(int) callback,
      required TimeOfDay startTime}) async {
    var currentDay = DateTime.now();
    await AndroidAlarmManager.periodic(const Duration(days: 1), id, callback,
        startAt: DateTime(currentDay.year, currentDay.month, currentDay.day,
            startTime.hour, startTime.minute));
  }

  static void showMedicineNotificationInterval(
      {required Duration interval,
      required int id,
      required String name,
      required dynamic Function(int) callback,
      required TimeOfDay startTime}) async {
    var currentDay = DateTime.now();
    await AndroidAlarmManager.periodic(interval, id, callback,
        params: {'name': name},
        startAt: DateTime(currentDay.year, currentDay.month, currentDay.day,
            startTime.hour, startTime.minute));
  }

  void cancelMedicineNotification(int id) {
    AndroidAlarmManager.cancel(id);
  }
}

