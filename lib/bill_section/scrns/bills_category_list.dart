import 'package:flutter/material.dart';
import '../widget/bili_category_Item.dart';
import 'bills_listview.dart';
import '../widget/custom_app_bar.dart';

class BillsList extends StatelessWidget {
  const BillsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('فواتيري'),),
        body: ListView(
      children: [
        const TotalPaymentMonth(),
         Column(
          children: [
            BillItem(
              iconBill: Icons.water_drop,
              billTitle: "فواتير المياه",
              paymentBills: "3000",
              iconColor: Colors.blueAccent,
              logic: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const BillsListView(),));
              },
            ),
            const BillItem(
              iconBill: Icons.call,
              billTitle: "فواتير الاتصالات",
              paymentBills: "3000",
              iconColor: Colors.greenAccent,
              logic: null,
            ),
            const BillItem(
              iconBill: Icons.electric_bolt,
              billTitle: "فواتير الكهرباء",
              paymentBills: "3000",
              iconColor: Colors.limeAccent,
              logic: null,
            ),
            const BillItem(
              iconBill: Icons.local_gas_station,
              billTitle: "فواتير البنزين",
              paymentBills: "3000",
              iconColor: Colors.redAccent,
              logic: null,
            ),
            const BillItem(
              iconBill: Icons.gas_meter,
              billTitle: "فواتير الغاز ",
              paymentBills: "3000",
              iconColor: Colors.blueGrey,
              logic: null,
            )
          ],
        ),
      ],
    ));
  }
}
