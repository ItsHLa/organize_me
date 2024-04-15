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
    await LocalNotificationService.flutterLocalNotificationsPlugin
        .zonedSchedule(
      id,
      medName,
      'لا تنسى دواءك',
      tz.TZDateTime(
        tz.local,
        currentTime.year,
        currentTime.month,
        currentTime.day,
        timeOfDose.hour,
        timeOfDose.minute,
      )
          .subtract(
            const Duration(minutes: 15),
          )
          .add(
        Duration(days: 1, hours: hoursBetweenShots),
          ),
      medicienDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
