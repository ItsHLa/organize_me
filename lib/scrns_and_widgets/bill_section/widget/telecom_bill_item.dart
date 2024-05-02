import 'package:flutter/material.dart';
import 'package:organize_me/constants.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/widget/my_row.dart';

class TelecomBills extends StatelessWidget {
  const TelecomBills({
    super.key,
    required this.date,
    required this.operationNumber,
    required this.phoneNumber,
    required this.paymentAmount,
  });

  final String date;

  final String operationNumber;
  final String phoneNumber;
  final String paymentAmount;

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
                  Text(operationNumber)
                ],
              ),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyRow(title: 'رقم الهاتف الثابت ', value: phoneNumber),
                  MyRow(
                      title: 'المبلغ                   ', value: paymentAmount),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: -4,
          right: -4,
          child: telecomBill,
        ),
      ],
    );
  }
}
