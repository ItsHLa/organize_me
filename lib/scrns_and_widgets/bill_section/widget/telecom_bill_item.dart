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
    return Card(
      child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              ListTile(
                title: Row(
                  children: [
                    telecomBill,
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
            ],
          )),
    );
  }
}
