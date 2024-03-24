
import 'package:flutter/material.dart';

import '../scrns/bills_list.dart';
import 'drawer_item.dart';
class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child:ListView(
        children: [
          const Padding(
            padding:  EdgeInsets.all(8.0),
            child: ListTile(
              leading: Icon(Icons.person),
              title: Text('مرحبا , مستخدم'),
              subtitle: Text(' phone Number'),
            ),
          ),
          const Divider(),
          DrawerItem(
              icon: Icons.payment,
              title: 'فواتيري',
              logic: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const BillsList(),));
              }),
          DrawerItem(icon: Icons.payments_outlined, title: 'دفع فاتورة', logic: (){

          }),
          DrawerItem(icon: Icons.gps_fixed, title: 'خدمة الخرائط', logic: (){}),
          DrawerItem(icon: Icons.settings, title: 'الإعدادات', logic: (){}),
        ],
      ) ,
    );
  }
}