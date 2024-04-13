import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:organize_me/services/local_notification_service/local_notification.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class BillsNotification extends LocalNotificationService {
  static void cancelBillNotification(int billId) {
    LocalNotificationService.flutterLocalNotificationsPlugin.cancel(billId);
  }

  static void showBillSimpleNotification() async {
    AndroidNotificationDetails billsAndroidNotificationDetails =
        const AndroidNotificationDetails('bills_channel', 'Bills',
            importance: Importance.max, priority: Priority.high);
    NotificationDetails billsdetails =
        NotificationDetails(android: billsAndroidNotificationDetails);
    tz.initializeTimeZones();
    String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
    await LocalNotificationService.flutterLocalNotificationsPlugin
        .zonedSchedule(
            1,
            ' فواتيرك! ',
            ' لا تنسى دفع فواتيرك',
            tz.TZDateTime(tz.local, DateTime.now().year, DateTime.now().month,
                DateTime.now().day, 12, 0),
            billsdetails,
            uiLocalNotificationDateInterpretation:
                UILocalNotificationDateInterpretation.absoluteTime);
  }
}
