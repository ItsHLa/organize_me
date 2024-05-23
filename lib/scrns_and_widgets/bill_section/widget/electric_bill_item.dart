import 'package:flutter/material.dart';
import 'package:organize_me/constants.dart';

import 'bill_details.dart';

class ElectricBills extends StatelessWidget {
  const ElectricBills({
    super.key,
    required this.date,
    required this.time,
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
  final String time;
  final String gov;
  final String billingNumber;
  final String subscriptionNumber;
  final String operationNumber;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(3.0),
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
                  'رقم الفوترة',
                  'رقم الاشتراك',
                  'رقم العملية',
                ],
                subtitle: [
                  invoiceNumber,
                  paymentAmount,
                  commissionAmount,
                  date,
                  time,
                  gov,
                  billingNumber,
                  subscriptionNumber,
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
                  Icons.confirmation_num_outlined,
                  Icons.receipt_long_outlined,
                ],
              ),
            ));
          },
          trailing: electricBill,
          title: Text(
            'رقم الفاتورة $billingNumber',
            textAlign: TextAlign.right,
          ),
          subtitle: Text(
            date,
            textAlign: TextAlign.right,
          ),
        ),
      ),
    );
  }
}
