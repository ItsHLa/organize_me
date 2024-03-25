
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../scrns/bills_list.dart';
import 'payment_widget.dart';
import 'drawer_item.dart';
class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  bool nightModeOn = false ;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child:Padding(
        padding: const EdgeInsets.all(9),
        child: ListView(
          children: [
            const Padding(
              padding:  EdgeInsets.all(10),
              child: ListTile(
                contentPadding: EdgeInsets.all(10),
                leading: Icon(Icons.person),
                title: Text('مرحبا , مستخدم'),
                subtitle: Text(' 09976564545'),
              ),
            ),
            const Divider(),
            DrawerItem(
                icon: Icons.payment,
                title: 'فواتيري',
                logic: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const BillsList(),));
                }),
            DrawerItem(icon: Icons.payments_outlined ,color: calls, title: 'دفع فواتيري', logic: (){
              showDialog(context: context, builder: (context) => const PaymentPage());
            }),
            DrawerItem(icon: Icons.gps_fixed_outlined , color: gasStation ,title: 'خدمة الخرائط', logic: (){

            }),
            SwitchListTile(value: nightModeOn, onChanged: (value) {
              setState(() {
                nightModeOn = value;
              });
            },

              title:const  Row(
                children:
                [
                  Icon(Icons.nightlight_outlined , color: elec,),
                  Padding(padding: EdgeInsets.all(8),
                    child: Text('وضع ليلي'),
                  ),],)
            )
          ],
        ),
      ) ,
    );
  }
}