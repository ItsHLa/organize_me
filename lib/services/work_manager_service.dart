import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/models/electric_bill.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/models/telecom_bill.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/models/water_bill.dart';
import 'package:organize_me/services/api_calls.dart';
import 'package:organize_me/services/app_notification.dart';
import 'package:organize_me/user.dart';
import 'package:workmanager/workmanager.dart';

import '../scrns_and_widgets/bill_section/models/bill.dart';

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
    Map<String, dynamic> userInfo = await User.userInfo();
    Map user = jsonDecode((await ApiCalls.getUser(userInfo['id'])).body);
    List<Bill> elBills =
        await ElectricBill.getBillsFromId(user['last_el_bill']);
    List<Bill> waBills = await WaterBill.getBillsFromId(user['last_wa_bill']);
    List<Bill> telBills =
        await TelecomBill.getBillsFromId(user['last_tel_bill']);
    await ApiCalls.addBills(userInfo['id'], 'el', elBills);
    await ApiCalls.addBills(userInfo['id'], 'wa', waBills);
    await ApiCalls.addBills(userInfo['id'], 'tel', telBills);
  }
}
