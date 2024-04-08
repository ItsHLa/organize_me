import 'package:flutter/material.dart';

import 'bill_item.dart';

class BillsListView extends StatelessWidget {
  const BillsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(15),
      itemBuilder: (context, index) {
        return const MyBills();
      },
    );
  }
}
