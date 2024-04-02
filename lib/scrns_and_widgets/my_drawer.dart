import 'package:flutter/material.dart';
import 'package:organize_me/scrns_and_widgets/scheduling_dates_section/calender_view.dart';

import '../constants.dart';
import 'bill_section/bills_category_list.dart';
import 'drawer_item.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  bool nightModeOn = false;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(height: 15,),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'القائمة',
                style: TextStyle(fontSize: 20),
              ),
            ),
            DrawerItem(
                icon: Icons.payment,
                title: 'فواتيري',
                logic: () {
                  showDialog(
                      context: context,
                      builder: (context) => const BillsList());
                }),
            DrawerItem(
                icon: Icons.calendar_month,
                title: 'مواعيدي ',
                logic: () {
                  showDialog(
                      context: context,
                      builder: (context) => const CalenderView());
                }),
            /* DrawerItem(
            icon: Icons.gps_fixed_outlined,
            color: gasStation,
            title: 'خدمة الخرائط',
            logic: () {}),*/
            Card(
              child: SwitchListTile(
                  value: nightModeOn,
                  onChanged: (value) {
                    setState(() {
                      nightModeOn = value;
                    });
                  },
                  title: const Row(
                    children: [
                      Icon(
                        Icons.wb_sunny_outlined,
                        color: yellow,
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text('وضع ليلي'),
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
