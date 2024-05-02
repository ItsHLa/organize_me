import 'package:flutter/material.dart';
import 'package:organize_me/constants.dart';

import 'my_row.dart';

class ElectricBills extends StatelessWidget {
  const ElectricBills({
    super.key,
    required this.date,
    required this.operationNumber,
    required this.billingNumber,
    required this.subscriptionNumber,
    required this.paymentAmount,
  });

  final String date;

  final String operationNumber;
  final String billingNumber;
  final String subscriptionNumber;
  final String paymentAmount;

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
                  Text(operationNumber)
                ],
              ),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyRow(title: 'رقم الفوترة     ', value: billingNumber),
                  MyRow(title: 'رقم الاشتراك  ', value: subscriptionNumber),
                  MyRow(title: 'المبلغ             ', value: paymentAmount),
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
