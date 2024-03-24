import 'package:flutter/material.dart';

class BillItem extends StatelessWidget {
  const BillItem({super.key ,required this.iconBill ,required this.BillTitle , required this.paymentBills, required this.iconColor, this.logic});
  final IconData iconBill ;
  final  String BillTitle;
  final String paymentBills;
  final Color iconColor;
  final void Function()? logic;

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: const EdgeInsets.symmetric(horizontal: 10 ),
      child: Card(
        child: ListTile(
          trailing: const Icon(Icons.info_outline),
          onTap: logic ,
          leading:  Icon(iconBill , color:iconColor ,),
          title: Padding(
            padding: const EdgeInsets.only(top:4.0 , left: 4 ,right: 4),
            child: Text(BillTitle),
          ),
          subtitle:  Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                Text("   دفعك الكلي  " ),
                Text(paymentBills)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
