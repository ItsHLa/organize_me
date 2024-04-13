import 'package:flutter/material.dart';
import 'package:organize_me/constants.dart';

import 'widget/bili_category_item.dart';

class BillsList extends StatelessWidget {
  const BillsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
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
