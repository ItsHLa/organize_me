import 'package:flutter/material.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/widget/payment_widget.dart';

import 'widget/bill_item.dart';

class BillsListView extends StatelessWidget {
  const BillsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          showDialog(
              context: context, builder: (context) => const PaymentPage());
        },
        child: const Icon(
          Icons.payments,
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(15),
        itemBuilder: (context, index) {
          return const MyBills();
        },
      ),
    );
  }
}
