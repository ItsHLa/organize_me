import 'package:flutter/material.dart';
import '../widget/bill_item.dart';
import '../widget/custom_app_bar.dart';

class BillsList extends StatelessWidget {
  const BillsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 60,
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        const TotalPaymentMonth(),
        const Column(
          children: [
            BillItem(
              iconBill: Icons.water_drop,
              billTitle: "فواتير المياه",
              paymentBills: "3000",
              iconColor: Colors.blueAccent,
              logic: null,
            ),
            BillItem(
              iconBill: Icons.call,
              billTitle: "فواتير الاتصالات",
              paymentBills: "3000",
              iconColor: Colors.greenAccent,
              logic: null,
            ),
            BillItem(
              iconBill: Icons.electric_bolt,
              billTitle: "فواتير الكهرباء",
              paymentBills: "3000",
              iconColor: Colors.limeAccent,
              logic: null,
            ),
            BillItem(
              iconBill: Icons.local_gas_station,
              billTitle: "فواتير البنزين",
              paymentBills: "3000",
              iconColor: Colors.redAccent,
              logic: null,
            ),
            BillItem(
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
