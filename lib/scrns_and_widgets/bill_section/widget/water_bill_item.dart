import 'package:flutter/material.dart';
import 'package:organize_me/constants.dart';

import 'bill_details.dart';

class WaterBills extends StatelessWidget {
  const WaterBills({
    super.key,
    required this.date,
    required this.time,
    required this.barcodeNumber,
    required this.operationNumber,
    required this.counterNumber,
    required this.paymentAmount,
    required this.commissionAmount,
    required this.gov,
    required this.receiptNumber,
  });

  final String paymentAmount;
  final String commissionAmount;
  final String date;
  final String time;
  final String gov;
  final String receiptNumber;
  final String barcodeNumber;
  final String counterNumber;
  final String operationNumber;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          elevation: 40,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => BillCategoryDetail(
                    title: const [
                      'رقم الفاتورة',
                      'المبلغ',
                      'عمولة دفع الفاتورة',
                      'تاريخ',
                      'وقت',
                      'المحافظة',
                      'رقم الباركود',
                      'رقم العداد',
                      'رقم العملية',
                    ],
                    subtitle: [
                      receiptNumber,
                      paymentAmount,
                      commissionAmount,
                      date,
                      time,
                      gov,
                      barcodeNumber,
                      counterNumber,
                      operationNumber,
                    ],
                    icon: const [
                      Icons.receipt_outlined,
                      Icons.monetization_on_outlined,
                      Icons.money,
                      Icons.date_range_outlined,
                      Icons.timer_outlined,
                      Icons.place_outlined,
                      Icons.numbers_outlined,
                      Icons.numbers_outlined,
                      Icons.receipt_long_outlined,
                    ],
                  ),
                ));
              },
              title: Text('رقم الايصال$receiptNumber'),
              subtitle: Text(date),
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
