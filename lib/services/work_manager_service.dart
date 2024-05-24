import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:organize_me/constants.dart';
import 'package:organize_me/services/api_calls.dart';
import 'package:organize_me/services/app_notification.dart';
import 'package:workmanager/workmanager.dart';

class WorkManagerService {
  static void registerMyTask(
      {required String uniqueTaskName,
      required String taskName,
      required Duration frequency,
      required Duration initialDelay,
      int? id,
      String? title,
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
    registerMyTask(
      uniqueTaskName: 'check Internet',
      taskName: 'check Internet',
      frequency: const Duration(hours: 1),
      initialDelay: Duration.zero,
    );
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
        addBills();
        break;
    }
    return Future.value(true);
  });
}

addBills() async {
  var result = await (Connectivity().checkConnectivity());
  if (result.contains(ConnectivityResult.wifi) ||
      result.contains(ConnectivityResult.mobile)) {
    // await ApiCalls.addBills(me.id, 'el', elBills);
    // await ApiCalls.addBills(me.id, 'wa', waBills);
    // await ApiCalls.addBills(me.id, 'tel', telBills);
  }
}
