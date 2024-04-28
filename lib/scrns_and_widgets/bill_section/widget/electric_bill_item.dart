import 'package:flutter/material.dart';
import 'package:organize_me/constants.dart';

import 'my_row.dart';

class ElectricBills extends StatelessWidget {
  const ElectricBills(
      {super.key,
      required this.date,
      required this.numberOfProcess,
      required this.numberOfBill,
      required this.numberOfPartici,
      required this.payment});

  final String date;

  final String numberOfProcess;
  final String numberOfBill;
  final String numberOfPartici;
  final String payment;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(3.0),
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
                  MyRow(title: 'رقم الفوترة     ', value: numberOfBill),
                  MyRow(title: 'رقم الاشتراك  ', value: numberOfPartici),
                  MyRow(title: 'المبلغ             ', value: payment),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: -4,
          right: -4,
          child: electricBill,
        )
      ],
    );
  }
}
