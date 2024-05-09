import 'package:flutter/material.dart';

import 'my_row.dart';

class ElectricBillDetail extends StatelessWidget {
  const ElectricBillDetail({
    super.key,
    required this.date,
    required this.time,
    required this.operationNumber,
    required this.paymentAmount,
    required this.billingNumber,
    required this.subscriptionNumber,
    required this.commissionAmount,
    required this.invoiceNumber,
    required this.gov,
  });

  final String paymentAmount;
  final String commissionAmount;
  final String invoiceNumber;
  final String date;
  final String time;
  final String gov;
  final String billingNumber;
  final String subscriptionNumber;
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
            MyRow(title: 'رقم الفوترة     ', value: billingNumber),
            const Divider(),
            MyRow(title: 'رقم الاشتراك  ', value: subscriptionNumber),
            const Divider(),
            MyRow(title: 'رقم الفاتورة  ', value: billingNumber),
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
