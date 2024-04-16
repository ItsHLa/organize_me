import 'package:organize_me/services/local_notification_service/bills_notification.dart';
import 'package:workmanager/workmanager.dart';

class WorkManagerService {
  void registerMyBillNotification() async {
    await Workmanager().registerPeriodicTask(
      'BillsNotification',
      'show Bills notification',
      frequency: const Duration(days: 1),
    );
  }

  // init work manager service
  Future<void> init() async {
    await Workmanager().initialize(workManagerBillNotification,
        // the function that we want to be called  on background
        isInDebugMode: true);
    registerMyBillNotification(); // calling register method to register tasks that we want to be called in background
  }

  void cancelTask(String id) {
    // cancel the task by its uniqeName
    Workmanager().cancelByUniqueName(id);
  }
}

// this function needs to be out of class (Top level) or inside it (static) and return Future<bool>
@pragma('vm_entry_point') // this notation is required
void workManagerBillNotification() {
  Workmanager().executeTask((taskName, inputData) {
    // here we put the code that needs to be executed in the background
    BillsNotification.showBillMonthlyNotification();
    //  BillsNotification.showSimpleBill();
    return Future.value(true); //the return type
  });
}

