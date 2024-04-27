import 'package:flutter/material.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/widget/telecom_list.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/widget/water_list.dart';
import 'package:organize_me/scrns_and_widgets/my_list_view.dart';

import 'electronic_bill_list.dart';

class BillsListView extends StatelessWidget {
  const BillsListView({super.key, required this.typeOfBill});

  final String typeOfBill;

  @override
  Widget build(BuildContext context) {
    return MyListView(
        dataList: const [],
        itemCount: 100,
        itemBuilder: (context, index) {
          switch (typeOfBill) {
            case 'water':
              return const WaterList(
                date: '',
                barcode: '',
                payment: '',
                numberOfProcess: '',
                numberOfCounter: '',
              );
            case 'electric':
              return const ElectricList(
                date: '',
                barcode: '',
                payment: '',
                numberOfProcess: '',
                numberOfPartici: '',
              );
            case 'telecom':
              return const TelecomList(
                payment: '',
                numberOfProcess: '',
                date: '',
                phoneNumber: '',
              );
            default:
              return Container();
          }
        });
  }
}
