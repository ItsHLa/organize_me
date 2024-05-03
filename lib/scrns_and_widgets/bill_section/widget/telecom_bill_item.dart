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
                  subtitle: Text(operationNumber),
                ))),
        Positioned(
          top: -4,
          right: -4,
          child: telecomBill,
        ),
      ],
    );
  }
}


