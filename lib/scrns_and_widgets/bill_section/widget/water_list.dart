import 'package:flutter/material.dart';
import 'package:organize_me/scrns_and_widgets/my_list_view.dart';

import '../models/water_bill.dart';
import 'water_bill_item.dart';

class WaterList extends StatelessWidget {
  const WaterList({
    super.key,
    required this.bill,
  });

  final List<WaterBill> bill;

  @override
  Widget build(BuildContext context) {
    return MyListView(
        dataList: bill,
        itemCount: bill.length,
        itemBuilder: (context, index) {
          WaterBill current = bill[index];
          return WaterBills(
            date: current.date,
            operationNumber: current.operationNumber,
            paymentAmount: current.paymentAmount.toString(),
            barcodeNumber: current.barcodeNumber,
            counterNumber: current.counterNumber,
          );
        });
  }
}
