import 'package:flutter/material.dart';
import 'package:organize_me/constants.dart';

import 'bill_details.dart';

class TelecomBills extends StatelessWidget {
  const TelecomBills({
    super.key,
    required this.date,
    required this.time,
    required this.operationNumber,
    required this.phoneNumberEmail,
    required this.paymentAmount,
    required this.commissionAmount,
    required this.invoiceNumber,
  });

  final String paymentAmount;
  final String commissionAmount;
  final String invoiceNumber;
  final String date;
  final String time;
  final String phoneNumberEmail;
  final String operationNumber;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 9,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListTile(
            trailing: telecomBill,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => BillCategoryDetail(
                  title: const [
                    'المبلغ',
                    'رقم الفاتورة',
                    'عمولة دفع الفاتورة',
                    'تاريخ',
                    'وقت',
                    'الهاتف/البريد',
                    'رقم العملية',
                  ],
                  subtitle: [
                    paymentAmount,
                    invoiceNumber,
                    commissionAmount,
                    date,
                    time,
                    phoneNumberEmail,
                    operationNumber,
                  ],
                  icon: const [
                    Icons.monetization_on_outlined,
                    Icons.receipt_outlined,
                    Icons.monetization_on_outlined,
                    Icons.date_range_outlined,
                    Icons.timer_outlined,
                    Icons.alternate_email,
                    Icons.receipt_long_outlined
                  ],
                ),
              ));
            },
            title: Text(
              '$invoiceNumber رقم الفاتورة ',
              textAlign: TextAlign.right,
            ),
            subtitle: Text(
              'التاريخ $date',
              textAlign: TextAlign.right,
            )),
      ),
    );
  }
}
