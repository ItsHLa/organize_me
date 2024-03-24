import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BillsTableRow extends StatelessWidget {
  const BillsTableRow ({super.key, required this.barcode, required this.counter, required this.operationNum, required this.payment, required this.date});

  final String barcode;
  final String counter;
  final String operationNum;
  final String payment;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BillsTableCell(data: barcode),
            BillsTableCell(data: counter),
            BillsTableCell(data: operationNum),
            BillsTableCell(data: payment),
            BillsTableCell(data: date),
          ],
        )
      ),
    )
      ;
  }
}



class BillsTableCell extends StatelessWidget {
  const BillsTableCell({super.key, required this.data});
  final String data;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding:const EdgeInsets.only( left : 4,right:4,top :9.0 , bottom :9),
        child: Text(data));
  }
}
