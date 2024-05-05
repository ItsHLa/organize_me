import 'package:flutter/material.dart';
import 'package:organize_me/constants.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/widget/tele_bill_datail.dart';

class TelecomBills extends StatelessWidget {
  const TelecomBills(
      {super.key,
      required this.date,
      required this.operationNumber,
      required this.phoneNumberEmail,
      required this.paymentAmount,
      required this.commissionAmount,
      required this.invoiceNumber});

  final String paymentAmount;
  final String commissionAmount;
  final String invoiceNumber;
  final String date;
  final String phoneNumberEmail;
  final String operationNumber;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: ListTile(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => TelecomBillDetail(
                      date: date,
                      phoneNumberEmail: phoneNumberEmail,
                      paymentAmount: paymentAmount,
                      operationNumber: operationNumber,
                      commissionAmount: commissionAmount,
                    ),
                  );
                },
                title: Text(date),
                subtitle: Text(operationNumber)),
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
