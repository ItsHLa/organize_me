import 'package:flutter/material.dart';

import 'my_row.dart';

class WaterBillDetail extends StatelessWidget {
  const WaterBillDetail({
    super.key,
    required this.date,
    required this.operationNumber,
    required this.paymentAmount,
    required this.barcodeNumber,
    required this.counterNumber,
    required this.commissionAmount,
    required this.gov,
    required this.receiptNumber,
  });

  final String paymentAmount;
  final String commissionAmount;
  final String date;
  final String gov;
  final String receiptNumber;
  final String barcodeNumber;
  final String counterNumber;
  final String operationNumber;

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
            MyRow(title: 'رقم العداد     ', value: counterNumber),
            const Divider(),
            MyRow(title: 'رقم الباركود  ', value: barcodeNumber),
            const Divider(),
            MyRow(title: 'رقم الايصال  ', value: receiptNumber),
            const Divider(),
            MyRow(title: 'المحافظة  ', value: gov),
            const Divider(),
            MyRow(title: 'عمولة الدفع   ', value: commissionAmount),
            const Divider(),
            MyRow(title: 'المبلغ             ', value: paymentAmount),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
