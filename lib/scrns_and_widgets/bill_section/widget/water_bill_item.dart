import 'package:flutter/material.dart';
import 'package:organize_me/constants.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/widget/my_row.dart';

class WaterBills extends StatelessWidget {
  const WaterBills({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              ListTile(
                title: Row(
                  children: [
                    waterBill,
                    SizedBox(
                      width: 10,
                    ),
                    Text('9/4/2024'),
                    Spacer(),
                    Text('0998898')
                  ],
                ),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MyRow(title: 'رقم الباركود', value: "123"),
                    MyRow(title: 'رقم العداد  ', value: "123"),
                    MyRow(title: 'المبلغ         ', value: "123"),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
