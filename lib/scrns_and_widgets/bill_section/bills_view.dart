import 'package:flutter/material.dart';
import 'package:organize_me/scrns_and_widgets/app_bar.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/widget/bili_category_item.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/widget/bills_listview.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/widget/payment_widget.dart';

import '../../constants.dart';

class MyBills extends StatelessWidget {
  const MyBills({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          showDialog(
              context: context, builder: (context) => const PaymentPage());
        },
        child: const Icon(
          Icons.payments,
        ),
      ),
      body: Column(
        children: [
          const MAppBar(),
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                BillItem(
                  iconBill: Icons.water_drop,
                  billTitle: "فواتير المياه",
                  iconColor: blue,
                ),
                BillItem(
                  iconBill: Icons.electric_bolt,
                  billTitle: "فواتير الكهرباء",
                  iconColor: yellow,
                  logic: null,
                ),
                BillItem(
                  iconBill: Icons.call,
                  billTitle: "فواتير الاتصالات",
                  iconColor: green,
                  logic: null,
                ),
              ],
            ),
          ),
          const Expanded(child: BillsListView())
        ],
      ),
    );
  }
}
