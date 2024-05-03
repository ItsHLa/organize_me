import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:organize_me/constants.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/widget/auth_page.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/widget/payment_widget.dart';
import 'package:organize_me/scrns_and_widgets/floating_action_button.dart';
import 'package:organize_me/services/work_manager_service.dart';

import 'monthly_bills.dart';

class MyBills extends StatelessWidget {
  const MyBills({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: MyFab(
          children: [
            SpeedDialChild(
                child: const Icon(
                  Icons.payments,
                ),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => const PaymentPage());
                }),
            SpeedDialChild(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                        title: const Text(
                          'هل توافق على تذكيرك بدفع فواتيرك كل شهر ؟',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18),
                        ),
                        actionsAlignment: MainAxisAlignment.center,
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                WorkManagerService.registerMyTask(
                                    uniqueTaskName: 'show bill notification',
                                    taskName: 'show bill notification',
                                    frequency: const Duration(days: 30),
                                    initialDelay: Duration.zero,
                                    id: 0,
                                    title: 'bills');
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: appColorTheme),
                              child: const Text('اوافق'))
                        ]),
                  );
                },
                child: const Icon(Icons.notifications_active_outlined)),
            SpeedDialChild(
                child: const Icon(Icons.settings_backup_restore_sharp),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => const Auth(),
                  );
                })
          ],
        ),
        body: const MonthlyChart());
  }
}
