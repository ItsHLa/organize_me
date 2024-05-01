import 'package:flutter/material.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/widget/telecom_bill_item.dart';
import 'package:organize_me/scrns_and_widgets/my_list_view.dart';

import '../models/telecom_bill.dart';

class TelecomList extends StatelessWidget {
  const TelecomList({
    super.key,
    required this.bill,
  });

  final List<TelecomBill> bill;

  @override
  Widget build(BuildContext context) {
    return MyListView(
        dataList: bill,
        itemCount: bill.length,
        itemBuilder: (context, index) {
          TelecomBill currentBill = bill[index];
          return TelecomBills(
            payment: currentBill.commissionAmount.toString(),
            numberOfProcess: currentBill.operationNumber,
            date: currentBill.date,
            phoneNumber: currentBill.phoneNumberEmail,
          );
        });
  }
}
