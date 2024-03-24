import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:organize_me/constants.dart';
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
                   BillItem(iconBill: Icons.water_drop, BillTitle: "فواتير المياه", paymentBills: "3000" , iconColor: water, logic: null,),
                   BillItem(iconBill: Icons.call, BillTitle: "فواتير الاتصالات", paymentBills: "3000",iconColor: calls , logic: null,),
                   BillItem(iconBill: Icons.electric_bolt, BillTitle: "فواتير الكهرباء", paymentBills: "3000",iconColor: elec,logic: null,),
                   BillItem(iconBill: Icons.local_gas_station, BillTitle: "فواتير البنزين", paymentBills: "3000",iconColor: gasStation, logic: null,),
                   BillItem(iconBill: Icons.gas_meter, BillTitle: "فواتير الغاز ", paymentBills: "3000" , iconColor: gas, logic: null,)
                 ],
                             ),
              ),
           ],
         )


     ) ;
   }
 }
