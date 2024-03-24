
import 'package:flutter/material.dart';
import 'package:organize_me/bill_section/widget/table_row.dart';

class BillsListView extends StatelessWidget {
  const BillsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return const BillsTableRow(
              barcode: '123',
              counter: '123',
              operationNum: '123',
              payment: '123',
              date: '123');
        },),);
  }
}
