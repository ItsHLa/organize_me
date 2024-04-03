import 'package:flutter/material.dart';
import 'package:organize_me/scrns_and_widgets/scheduling_dates_section/calender_view.dart';
import 'package:organize_me/scrns_and_widgets/settings.dart';

import 'bill_section/bills_category_list.dart';
import 'drawer_item.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(
              height: 15,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'القائمة',
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            DrawerItem(
                icon: Icons.payment,
                title: 'فواتيري',
                logic: () {
                  showDialog(
                      context: context,
                      builder: (context) => const BillsList());
                }),
            const Divider(),
            DrawerItem(
                icon: Icons.calendar_month,
                title: 'مواعيدي ',
                logic: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CalenderView(),
                  ));
                }),
            const Divider(),
            DrawerItem(
                icon: Icons.settings,
                title: 'الاعدادات',
                logic: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const Settings(),
                  ));
                }),
          ],
        ),
      ),
    );
  }
}
