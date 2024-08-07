import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/widget/payment_widget.dart';
import 'package:organize_me/scrns_and_widgets/floating_action_button.dart';

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
                builder: (context) => const PaymentPage(),
              );
            },
          ),
        ],
      ),
      body: const MonthlyChart(),
    );
  }
}
