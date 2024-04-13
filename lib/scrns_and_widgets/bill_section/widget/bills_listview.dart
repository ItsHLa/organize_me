import 'package:flutter/material.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/widget/telecom_bill_item.dart';
import 'package:organize_me/scrns_and_widgets/my_list_view.dart';

import 'electric_bills.dart';
import 'water_bill_item.dart';

class BillsListView extends StatelessWidget {
  const BillsListView({
    super.key,
    //   required this.typeOfBill
  });

  final String typeOfBill = 'telecom';

//  final List Bills ;

  @override
  Widget build(BuildContext context) {
    return MyListView(
        dataList: [],
        itemCount: 100,
        itemBuilder: (context, index) {
          switch (typeOfBill) {
            case 'water':
              return const WaterBills();
            case 'electric ':
              return const TelecomBills();
            case ' telecom ':
              return const ElectricBills();
            default:
              return ElectricBills();
          }
        });
  }
}
