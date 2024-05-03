import 'package:flutter/material.dart';

import 'my_row.dart';

class TelecomBillDetail extends StatelessWidget {
  const TelecomBillDetail(
      {super.key,
      required this.date,
      required this.operationNumber,
      required this.phoneNumberEmail,
      required this.paymentAmount,
      required this.commissionAmount});

  final String date;
  final String operationNumber;
  final String phoneNumberEmail;
  final String paymentAmount;
  final String commissionAmount;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      child: SingleChildScrollView(
        child: Column(
          children: [
            MyRow(title: 'رقم العملية', value: operationNumber),
            const Divider(),
            MyRow(title: ' التاريخ', value: date),
            const Divider(),
            MyRow(title: 'رقم الفاتورة', value: operationNumber),
            const Divider(),
            MyRow(title: 'رقم الهاتف الثابت ', value: phoneNumberEmail),
            const Divider(),
            MyRow(title: 'المبلغ                   ', value: paymentAmount),
            const Divider(),
            MyRow(
                title: 'الدفع للفاتورة                 ',
                value: commissionAmount),
          ],
        ),
      ),
    );
  }
}
