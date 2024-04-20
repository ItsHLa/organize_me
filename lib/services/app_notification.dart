import 'package:flutter/material.dart';

import 'local_notification.dart';

class AppNotification extends LocalNotificationService {
  static showSimpleMedicineNotification(
      {required int id, required String name}) async {
    LocalNotificationService.showMedicineNotification(id: id, name: name);
  }

  static showSimpleBillNotification() async {
    LocalNotificationService.showSimpleBillNotification(
        id: 0, body: 'لا تنسى دفع فواتيرك الشهرية');
  }

  static showSimpleBreadNotification({required String body}) async {
    LocalNotificationService.showSimpleBillNotification(id: 1, body: body);
  }

  static showSimpleGasNotification({required String body}) async {
    LocalNotificationService.showSimpleBillNotification(id: 2, body: body);
  }

  static showSimpleGasStationNotification({required String body}) async {
    LocalNotificationService.showSimpleBillNotification(id: 3, body: body);
  }

  static void showTaskNotificationBeforeXMinutes(
      {required int id,
      required DateTime dateTime,
      required TimeOfDay taskTime,
      required String title,
      required String content,
      required int min}) {
    LocalNotificationService.showTaskNotification(
        id: id,
        dateTime: dateTime,
        taskTime: taskTime,
        title: title,
        content: content,
        min: min);
  }
}
