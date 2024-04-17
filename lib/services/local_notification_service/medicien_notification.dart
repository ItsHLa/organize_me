import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:organize_me/services/local_notification_service/local_notification.dart';

class MedicienNotification extends LocalNotificationService {
  static void cancelMedicienNotification(int id) {
    LocalNotificationService.flutterLocalNotificationsPlugin.cancel(id);
  }

  static showSimpleNotification({id, name}) {
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
}
