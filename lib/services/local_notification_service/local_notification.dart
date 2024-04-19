import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract class LocalNotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void onTap(NotificationResponse notificationResponse) {}

  static Future initi() async {
    InitializationSettings initializationSettings =
        const InitializationSettings(
            android: AndroidInitializationSettings('@mipmap/ic_launcher'),
            iOS: DarwinInitializationSettings());
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onTap,
        onDidReceiveBackgroundNotificationResponse: onTap);
  }

  static showSimpleBillNotification({id, name}) {
    AndroidNotificationDetails billAndroidNotificationDetails =
        const AndroidNotificationDetails(
      'Bill_channel',
      'Bills',
      importance: Importance.max,
      priority: Priority.high,
    );
    NotificationDetails billDetails =
        NotificationDetails(android: billAndroidNotificationDetails);
    LocalNotificationService.flutterLocalNotificationsPlugin.show(
      id,
      name,
      'لا تنسى فواتيرك الشهرية',
      billDetails,
    );
  }

  static showSimpleMedicineNotification({id, name}) {
    AndroidNotificationDetails medicineAndroidNotificationDetails =
        const AndroidNotificationDetails(
      'medicine_channel',
      'Medicines',
      // visibility: NotificationVisibility.public,
      importance: Importance.max,
      priority: Priority.high,
    );
    NotificationDetails medicineDetails =
        NotificationDetails(android: medicineAndroidNotificationDetails);

    LocalNotificationService.flutterLocalNotificationsPlugin.show(
      id,
      name,
      'لا تنسى اخذ دواءك',
      medicineDetails,
    );
  }
}
