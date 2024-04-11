import 'package:flutter/material.dart';
import 'package:organize_me/services/local_notification_service/bills_notification.dart';

import '../../app_bar.dart';
import 'meds_grid.dart';

class MedsPage extends StatelessWidget {
  const MedsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        BillsNotification.showBillSimpleNotification();
      }),
      body: const Column(
        children: [MAppBar(), MedsGrid()],
      ),
    );
  }
}
