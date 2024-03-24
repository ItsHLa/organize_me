import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widget/bill_Item.dart';
import '../widget/custom_appBar.dart';

 class BillsList extends StatelessWidget {
   const BillsList({super.key});

   @override
   Widget build(BuildContext context) {
     return   Scaffold(
       appBar: AppBar( title: const Text('فواتيري' ,
         style: TextStyle(
             fontSize: 20,
             fontWeight: FontWeight.bold),)),
         body:Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children:  [
             const TotalPaymentMonth(),
              Expanded(
                child: ListView(
                 children: const [
                   BillItem(iconBill: Icons.water_drop, BillTitle: "فواتير المياه", paymentBills: "3000" , iconColor: Colors.blueAccent, logic: null,),
                   BillItem(iconBill: Icons.call, BillTitle: "فواتير الاتصالات", paymentBills: "3000",iconColor: Colors.greenAccent , logic: null,),
                   BillItem(iconBill: Icons.electric_bolt, BillTitle: "فواتير الكهرباء", paymentBills: "3000",iconColor: Colors.limeAccent,logic: null,),
                   BillItem(iconBill: Icons.local_gas_station, BillTitle: "فواتير البنزين", paymentBills: "3000",iconColor: Colors.redAccent, logic: null,),
                   BillItem(iconBill: Icons.gas_meter, BillTitle: "فواتير الغاز ", paymentBills: "3000" , iconColor: Colors.blueGrey, logic: null,)
                 ],
                             ),
              ),
           ],
         )


     ) ;
   }
 }
