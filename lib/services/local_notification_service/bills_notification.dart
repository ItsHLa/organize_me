import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:organize_me/services/local_notification_service/local_notification.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class BillsNotification extends LocalNotificationService {
  static void cancelBillNotification(int billId) {
    LocalNotificationService.flutterLocalNotificationsPlugin.cancel(billId);
  }

  static void showSimpleBill() async {
    AndroidNotificationDetails billsAndroidNotificationDetails =
        const AndroidNotificationDetails('bills_channel', 'Bills',
            importance: Importance.max, priority: Priority.high);
    NotificationDetails billsdetails =
        NotificationDetails(android: billsAndroidNotificationDetails);
    await LocalNotificationService.flutterLocalNotificationsPlugin
        .show(1, 'Organize Me', 'لاتنسى دفع فواتيرك', billsdetails);
  }

  static void showBillMonthlyNotification() async {
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
      scheduledTime = scheduledTime.add(const Duration(days: 7));
    }
    await LocalNotificationService.flutterLocalNotificationsPlugin
        .zonedSchedule(
            2,
            'Organize Me',
            ' لا تنسى دفع فواتيرك الشهرية ',
            tz.TZDateTime(tz.local, DateTime.now().year, DateTime.now().month,
                DateTime.now().day, 12, 0),
            billsdetails,
            uiLocalNotificationDateInterpretation:
                UILocalNotificationDateInterpretation.absoluteTime);
  }
}
