import 'package:flutter/material.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/widget/telecom_bill_item.dart';
import 'package:organize_me/scrns_and_widgets/my_list_view.dart';

class TelecomList extends StatelessWidget {
  const TelecomList(
      {super.key,
      required this.date,
      required this.numberOfProcess,
      required this.phoneNumber,
      required this.payment});

  final String date;

  final String numberOfProcess;
  final String phoneNumber;
  final String payment;

  @override
  Widget build(BuildContext context) {
    return MyListView(
        dataList: const [],
        itemCount: 100,
        itemBuilder: (context, index) {
          return const TelecomBills(
            payment: '',
            numberOfProcess: '',
            date: '',
            phoneNumber: '',
          );
        });
  }
}
