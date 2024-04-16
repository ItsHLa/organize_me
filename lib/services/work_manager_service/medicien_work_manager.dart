import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

class MedicineAlarm {
  static void showMedicineNotificationInterval(
      {required Duration interval,
      required int id,
      required Function callback}) async {
    await AndroidAlarmManager.periodic(
      interval,
      id,
      callback,
      // startAt: ,
      exact: true,
      allowWhileIdle: true,
      wakeup: true,
    );
  }

  void cancelMedicineNotification(int id) {
    AndroidAlarmManager.cancel(id);
  }
}
