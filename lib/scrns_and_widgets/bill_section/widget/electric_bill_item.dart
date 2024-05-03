import 'package:flutter/material.dart';
import 'package:organize_me/constants.dart';

import 'electri_bill_detail.dart';

class ElectricBills extends StatelessWidget {
  const ElectricBills({
    super.key,
    required this.date,
    required this.operationNumber,
    required this.billingNumber,
    required this.subscriptionNumber,
    required this.paymentAmount,
    required this.commissionAmount,
    required this.invoiceNumber,
    required this.gov,
  });

  final String paymentAmount;
  final String commissionAmount;
  final String invoiceNumber;
  final String date;
  final String gov;
  final String billingNumber;
  final String subscriptionNumber;
  final String operationNumber;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: ListTile(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => ElectricBillDetail(
                    date: date,
                    paymentAmount: paymentAmount,
                    operationNumber: operationNumber,
                    billingNumber: billingNumber,
                    subscriptionNumber: subscriptionNumber,
                    commissionAmount: commissionAmount,
                    invoiceNumber: invoiceNumber,
                    gov: gov,
                  ),
                );
              },
              subtitle: Text(date),
              title: Text('رقم الفاتورة : $billingNumber'),
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
