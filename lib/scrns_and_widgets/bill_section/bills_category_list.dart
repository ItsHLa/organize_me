import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'widget/bili_category_item.dart';

class BillsList extends StatelessWidget {
  const BillsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      //IconButton(onPressed: (){}, icon: Icon(Icons.me)),
      Expanded(
        child: ListView(
          padding: const EdgeInsets.all(5),
          scrollDirection: Axis.horizontal,
          children: const [
            BillItem(
              billTitle: 'فواتير الكهرباء',
            ),
            SizedBox(
              width: 3,
            ),
            BillItem(
              billTitle: 'فواتير المياه',
            ),
            SizedBox(
              width: 3,
            ),
            BillItem(
              billTitle: 'فواتير الاتصالات',
            )
          ],
        ),
      ),
    ]);
  }
}
