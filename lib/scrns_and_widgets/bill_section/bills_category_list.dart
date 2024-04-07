import 'package:flutter/material.dart';
import 'package:organize_me/constants.dart';

import 'widget/bili_category_item.dart';
import 'widget/bills_listview.dart';

class BillsList extends StatelessWidget {
  const BillsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BillItem(
          iconBill: Icons.water_drop,
          billTitle: "فواتير المياه",
          iconColor: blue,
          logic: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const BillsListView(),
              ),
            );
          },
        ),
        const BillItem(
          iconBill: Icons.electric_bolt,
          billTitle: "فواتير الكهرباء",
          iconColor: yellow,
          logic: null,
        ),
        const BillItem(
          iconBill: Icons.call,
          billTitle: "فواتير الاتصالات",
          iconColor: green,
          logic: null,
        ),
      ],
    );
  }
}
