import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract class LocalNotificationService {
  // putting the set up
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

  static showSimpleMedicineNotification({id, name}) {
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
      'Organize Me',
      'لا تنسى دواءك',
      medicienDetails,
    );
  }

  static showSimpleMonthlyBillNotification({id}) {
    AndroidNotificationDetails billsAndroidNotificationDetails =
        const AndroidNotificationDetails(
      'bills_channel',
      'bills',
      importance: Importance.max,
      priority: Priority.high,
    );
    NotificationDetails billsDetails =
        NotificationDetails(android: billsAndroidNotificationDetails);
    LocalNotificationService.flutterLocalNotificationsPlugin.show(
      id,
      'Organize Me',
      'لا تنسى دفع فواتيرك',
      billsDetails,
    );
  }
}
