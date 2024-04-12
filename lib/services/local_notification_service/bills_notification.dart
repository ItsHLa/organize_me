import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:organize_me/services/local_notification_service/local_notification.dart';

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

    await LocalNotificationService.flutterLocalNotificationsPlugin
        .show(1, ' فواتيرك! ', ' لا تنسى دفع فواتيرك', billsdetails);
  }
}
