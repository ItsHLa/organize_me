import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:organize_me/constants.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/models/bill.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/models/electric_bill.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/models/telecom_bill.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/models/water_bill.dart';
import 'package:organize_me/services/api_calls.dart';
import 'package:organize_me/services/app_notification.dart';
import 'package:workmanager/workmanager.dart';

class WorkManagerService {
  static void registerNotificationTask({
    required String uniqueTaskName,
    required String taskName,
    required Duration frequency,
    required Duration initialDelay,
    int? id,
    String? title,
    ExistingWorkPolicy? existingWorkPolicy,
  }) async {
    await Workmanager().registerPeriodicTask(
      uniqueTaskName,
      taskName,
      inputData: {'id': id, 'title': title},
      initialDelay: initialDelay,
      existingWorkPolicy: existingWorkPolicy,
      frequency: frequency,
    );
  }

  static void registerSendingData() async {
    await Workmanager().registerPeriodicTask(
      'check Internet',
      'check Internet',
      frequency: const Duration(hours: 1),
      constraints: Constraints(networkType: NetworkType.connected),
    );
  }

  static void registerMonthlyBillNotification() async {
    await Workmanager().registerPeriodicTask(
      'show bill notification',
      'show bill notification',
      initialDelay: const Duration(days: 20),
      frequency: const Duration(days: 30),
    );
  }

  // init work manager service
  Future<void> init() async {
    await Workmanager().initialize(callDispatcher);
    registerSendingData();
    registerMonthlyBillNotification();
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
          id: inputData!['id'],
          name: inputData['title'],
        );
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
    List<Bill> elBills = await Bill.getAllTempBills(ElectricBill.tempTableName);
    var r = await ApiCalls.addBills(me.id, 'el', elBills);
    if (r.statusCode == 200) {
      await Bill.clearTempTable(ElectricBill.tempTableName);
    }

    List<Bill> waBills = await Bill.getAllTempBills(WaterBill.tempTableName);
    r = await ApiCalls.addBills(me.id, 'wa', waBills);
    if (r.statusCode == 200) {
      await Bill.clearTempTable(WaterBill.tempTableName);
    }

    List<Bill> telBills = await Bill.getAllTempBills(TelecomBill.tempTableName);
    r = await ApiCalls.addBills(me.id, 'tel', telBills);
    if (r.statusCode == 200) {
      await Bill.clearTempTable(TelecomBill.tempTableName);
    }
  }
}
