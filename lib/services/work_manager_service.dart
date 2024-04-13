import 'package:organize_me/services/local_notification_service/bills_notification.dart';
import 'package:workmanager/workmanager.dart';

class WorkManagerService {
  void registerMyBillNotification() async {
    // register tasks
    // 'registerPeriodicTask' makes that task excecute every x [hours / days / minutes...]
    await Workmanager().registerPeriodicTask(
      'BillsNotification',
      // uniqueName of task needs it for canceling it for example
      'show Bills notification', // taskName
      frequency: const Duration(
          days:
              7), // the default value is 15m less that that it will set 15 minutes
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
