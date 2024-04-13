import 'package:flutter/material.dart';
import 'package:organize_me/scrns_and_widgets/app_bar.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/widget/bills_listview.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/widget/payment_widget.dart';
import 'package:organize_me/scrns_and_widgets/floating_action_button.dart';

import 'bills_category_list.dart';

class MyBills extends StatelessWidget {
  const MyBills({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: MyFab(
        icon: Icons.payments,
        onPressed: () {
          showDialog(
              context: context, builder: (context) => const PaymentPage());
        },
      ),
      body: const Column(
        children: [
          MAppBar(),
          SizedBox(
            height: 50,
            child: BillsList(),
          ),
          Expanded(child: BillsListView())
        ],
      ),
    );
  }
}
