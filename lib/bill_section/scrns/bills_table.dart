
import 'package:flutter/material.dart';

import '../widget/bills_listview.dart';
import '../widget/table_row.dart';

class BillsTable extends StatelessWidget {
  const BillsTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30,),
        const BillsTableRow(
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
