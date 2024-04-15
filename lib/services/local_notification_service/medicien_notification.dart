import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/medicien_section/models/med.dart';
import 'package:organize_me/services/local_notification_service/local_notification.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class MedicienNotification extends LocalNotificationService {
  static void cancelMedicienNotification(int id) {
    LocalNotificationService.flutterLocalNotificationsPlugin.cancel(id);
  }

  static showMedicienNotification({
    required Med med,
    required DateTime dateOfDose,
    required TimeOfDay timeOfDose,
    required TimeOfDay reminder,
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
    await LocalNotificationService.flutterLocalNotificationsPlugin
        .zonedSchedule(
      med.id,
      med.name,
      'لا تنسى دواءك',
      tz.TZDateTime(
        tz.local,
        dateOfDose.year,
        dateOfDose.month,
        dateOfDose.day,
        timeOfDose.hour,
        timeOfDose.minute,
      )
          .subtract(
            const Duration(minutes: 15),
          )
          .add(
            const Duration(days: 1),
          ),
      medicienDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
