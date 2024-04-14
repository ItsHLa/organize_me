import 'package:flutter/material.dart';
import 'package:organize_me/constants.dart';

import '../../icon_form.dart';
import 'my_row.dart';

class ElectricBills extends StatelessWidget {
  const ElectricBills({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              Center(
                child: IconForm(
                  child: electricBill,
                ),
              ),
              ListTile(
                title: Row(
                  children: [Text('9/4/2024'), Spacer(), Text('0998898')],
                ),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MyRow(title: 'رقم الفوترة     ', value: "123"),
                    MyRow(title: 'رقم الاشتراك  ', value: "123"),
                    MyRow(title: 'المبلغ             ', value: "123"),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
