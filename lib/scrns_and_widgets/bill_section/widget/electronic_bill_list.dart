import 'package:flutter/material.dart';
import 'package:organize_me/scrns_and_widgets/my_list_view.dart';

import 'electric_bill_item.dart';

class ElectricList extends StatelessWidget {
  const ElectricList(
      {super.key,
      required this.date,
      required this.barcode,
      required this.numberOfProcess,
      required this.numberOfPartici,
      required this.payment});

  final String date;

  final String barcode;
  final String numberOfProcess;
  final String numberOfPartici;
  final String payment;

  @override
  Widget build(BuildContext context) {
    return MyListView(
        dataList: const [],
        itemCount: 100,
        itemBuilder: (context, index) {
          return const ElectricBills(
            date: '',
            numberOfProcess: '',
            payment: '',
            numberOfBill: '',
            numberOfPartici: '',
          );
        });
  }
}
