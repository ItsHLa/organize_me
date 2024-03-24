import 'package:flutter/material.dart';

import '../widget/bills_listview.dart';
import '../widget/table_row.dart';

class BillsTable extends StatelessWidget {
  const BillsTable({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(
          height: 30,
        ),
        BillsTableRow(
            barcode: ' الباركود',
            counter: ' العداد',
            operationNum: ' العملية',
            payment: 'المبلغ',
            date: 'التاريخ'),
        BillsListView()
      ],
    );
  }
}
