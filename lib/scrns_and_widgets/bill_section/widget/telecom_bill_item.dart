import 'package:flutter/material.dart';
import 'package:organize_me/constants.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/widget/my_row.dart';

class TelecomBills extends StatelessWidget {
  const TelecomBills(
      {super.key,
      required this.date,
      required this.numberOfProcess,
      required this.phoneNumber,
      required this.payment});

  final String date;

  final String numberOfProcess;
  final String phoneNumber;
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
                  MyRow(title: 'رقم الهاتف الثابت ', value: phoneNumber),
                  MyRow(title: 'المبلغ                   ', value: payment),
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
