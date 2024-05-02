import 'package:flutter/material.dart';
import 'package:organize_me/scrns_and_widgets/my_list_view.dart';

import '../models/electric_bill.dart';
import 'electric_bill_item.dart';

class ElectricList extends StatelessWidget {
  const ElectricList({
    super.key,
    required this.bill,
  });

  final List<ElectricBill> bill;

  @override
  Widget build(BuildContext context) {
    return MyListView(
      dataList: bill,
      itemCount: bill.length,
      itemBuilder: (context, index) {
        ElectricBill currentBill = bill[index];
        return ElectricBills(
          date: currentBill.date,
          operationNumber: currentBill.operationNumber,
          paymentAmount: currentBill.paymentAmount.toString(),
          billingNumber: currentBill.billingNumber,
          subscriptionNumber: currentBill.subscriptionNumber,
        );
      },
    );
  }
}
