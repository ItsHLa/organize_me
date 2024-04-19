import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:organize_me/services/local_notification_service/local_notification.dart';

class MedicineNotification extends LocalNotificationService {
  static void showMedicineNotification() {
    AndroidNotificationDetails medicineDetails =
        const AndroidNotificationDetails('Medicines_Channel', 'Medicines',
            importance: Importance.max, priority: Priority.high);
    // NotificationDetails medicineDetails
  }
}
