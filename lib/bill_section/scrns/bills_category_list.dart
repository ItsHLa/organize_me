import 'package:flutter/material.dart';
import '../widget/bili_category_item.dart';
import 'bills_listview.dart';

class BillsList extends StatelessWidget {
  const BillsList({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.all(9),
        children: [
             Container(
                child: const Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('فواتيري' ,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                )),
            Column(
              children: [
                BillItem(
                  iconBill: Icons.water_drop,
                  billTitle: "فواتير المياه",
                  iconColor: Colors.blueAccent,
                  logic: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const BillsListView(),
                    ));
                  },
                ),
                const BillItem(
                  iconBill: Icons.electric_bolt,
                  billTitle: "فواتير الكهرباء",
                  iconColor: Colors.limeAccent,
                  logic: null,
                ),
                const BillItem(
                  iconBill: Icons.call,
                  billTitle: "فواتير الاتصالات",
                  iconColor: Colors.greenAccent,
                  logic: null,
                ),

          ])]
        );
  }
}
