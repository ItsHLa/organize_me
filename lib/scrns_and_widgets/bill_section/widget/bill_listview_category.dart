import 'package:flutter/material.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/widget/telecom_list.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/widget/water_list.dart';

import 'electric_bill_list.dart';

class BillsListView extends StatelessWidget {
  const BillsListView({super.key, required this.typeOfBill, this.bill});

  final String typeOfBill;
  final dynamic bill;

  @override
  Widget build(BuildContext context) {
    switch (typeOfBill) {
      case 'water':
        return WaterList(
          bill: bill,
        );
      case 'electric':
        return ElectricList(
          bill: bill,
        );
      case 'telecom':
        return TelecomList(
          bill: bill,
        );
      default:
        return Container();
    }
  }
}
