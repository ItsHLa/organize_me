import 'package:flutter/material.dart';
import 'package:organize_me/scrns_and_widgets/my_list_view.dart';

import 'water_bill_item.dart';

class WaterList extends StatelessWidget {
  const WaterList({
    super.key,
    required this.date,
    required this.barcode,
    required this.numberOfProcess,
    required this.numberOfCounter,
    required this.payment,
  });

  final String date;

  final String barcode;
  final String numberOfProcess;
  final String numberOfCounter;
  final String payment;

  @override
  Widget build(BuildContext context) {
    return MyListView(
        dataList: const [],
        itemCount: 100,
        itemBuilder: (context, index) {
          return const WaterBills(
            date: '',
            numberOfProcess: '',
            payment: '',
            barcode: '',
            numberOfCounter: '',
          );
        });
  }
}
