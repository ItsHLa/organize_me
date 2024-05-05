import 'package:flutter/material.dart';
import 'package:organize_me/constants.dart';

class WaterBills extends StatelessWidget {
  const WaterBills({
    super.key,
    required this.date,
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
          child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: ListTile(
                  title: Text('رقم الايصال$receiptNumber'),
                  subtitle: Text(date))),
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
