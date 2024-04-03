import 'package:flutter/material.dart';
import 'package:organize_me/constants.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/widget/payment_widget.dart';

import 'widget/bill_item.dart';

class BillsListView extends StatelessWidget {
  const BillsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('فواتيري'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const PaymentPage(),
                  ));
                },
                icon: const Icon(
                  Icons.payments,
                  color: green,
                )),
          )
        ],
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
