import 'package:flutter/material.dart';
import 'package:organize_me/constants.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/widget/my_row.dart';

class WaterBills extends StatelessWidget {
  const WaterBills(
      {super.key,
      required this.date,
      required this.barcode,
      required this.numberOfProcess,
      required this.numberOfCounter,
      required this.payment});

  final String date;

  final String barcode;
  final String numberOfProcess;
  final String numberOfCounter;
  final String payment;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: ListTile(
              title: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Text(date),
                  const Spacer(),
                  Text(numberOfProcess)
                ],
              ),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyRow(title: 'رقم الباركود', value: barcode),
                  MyRow(title: 'رقم العداد  ', value: numberOfCounter),
                  MyRow(title: 'المبلغ         ', value: payment),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: -4,
          right: -4,
          child: waterBill,
        )
      ],
    );
  }
}
