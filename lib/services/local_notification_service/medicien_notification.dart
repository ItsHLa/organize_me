import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:organize_me/services/local_notification_service/local_notification.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class MedicienNotification extends LocalNotificationService {
  static void cancelMedicienNotification(int id) {
    LocalNotificationService.flutterLocalNotificationsPlugin.cancel(id);
  }

  static showSimpleNatification({id, name}) {
    AndroidNotificationDetails medicienAndroidNotificationDetails =
        const AndroidNotificationDetails(
      'medicien_channel',
      'Mediciens',
      importance: Importance.max,
      priority: Priority.high,
    );
    NotificationDetails medicienDetails =
        NotificationDetails(android: medicienAndroidNotificationDetails);
    LocalNotificationService.flutterLocalNotificationsPlugin.show(
      id,
      name,
      'لا تنسى دواءك',
      medicienDetails,
    );
  }

  static showMedicienNotification({
    required int id,
    required String medName,
    required TimeOfDay timeOfDose,
    required int hoursBetweenShots,
  }) async {
    AndroidNotificationDetails medicienAndroidNotificationDetails =
        const AndroidNotificationDetails(
      'medicien_channel',
      'Mediciens',
      importance: Importance.max,
      priority: Priority.high,
    );
    NotificationDetails medicienDetails =
        NotificationDetails(android: medicienAndroidNotificationDetails);
    tz.initializeTimeZones();
    String currentTimeZone =
        (await FlutterTimezone.getLocalTimezone()).toString();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
    var currentTime = tz.TZDateTime.now(tz.local);
    var now = DateTime.now();
    var scheduledTime = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      timeOfDose.hour,
      timeOfDose.minute,
    );
    LocalNotificationService.flutterLocalNotificationsPlugin.periodicallyShow(
        id,
        medName,
        'لا تنسى دواءك',
        RepeatInterval.values[hoursBetweenShots],
        medicienDetails);
  }
}
