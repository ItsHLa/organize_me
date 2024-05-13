import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:organize_me/services/app_notification.dart';
import 'package:workmanager/workmanager.dart';

class WorkManagerService {
  static void registerMyTask(
      {required String uniqueTaskName,
      required String taskName,
      required Duration frequency,
      required Duration initialDelay,
      required int id,
      required String title,
      ExistingWorkPolicy? existingWorkPolicy}) async {
    await Workmanager().registerPeriodicTask(
      uniqueTaskName,
      taskName,
      inputData: {'id': id, 'title': title},
      initialDelay: initialDelay,
      existingWorkPolicy: existingWorkPolicy,
      frequency: frequency,
    );
  }

  // init work manager service
  Future<void> init() async {
    await Workmanager().initialize(callDispatcher, isInDebugMode: true);
  }

  static void cancelTask(String uniqueName) {
    Workmanager().cancelByUniqueName(uniqueName);
  }
}

@pragma('vm_entry_point')
void callDispatcher() {
  Workmanager().executeTask((taskName, inputData) {
    switch (taskName) {
      case 'show medicine notification':
        AppNotification.showSimpleMedicineNotification(
            id: inputData!['id'], name: inputData['title']);
        break;
      case 'show bill notification':
        AppNotification.showSimpleBillNotification();
        break;
      case 'check Internet':
        break;
    }
    return Future.value(true);
  });
}

checkInternetConnection() async {
  var result = await (Connectivity().checkConnectivity());
  if (result.contains(ConnectivityResult.wifi) ||
      result.contains(ConnectivityResult.mobile)) {
    // ApiCalls.addBills(userId, type, bills);
  }
}