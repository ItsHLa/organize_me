import 'package:flutter/material.dart';
import 'package:organize_me/bill_section/scrns/calender_view.dart';
import 'package:organize_me/task_section/scrns/task_view.dart';

import 'bill_section/widget/my_drawer.dart';

void main() {
  runApp(const OrganizeMe());
}

class OrganizeMe extends StatelessWidget {
  const OrganizeMe({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          drawer: const MyDrawer(),
          appBar: AppBar(
            title: const Text(
              'OrganizeMe',
              style: TextStyle(
                fontWeight: FontWeight.normal,
              ),
            ),
            bottom: const TabBar(
              tabs: [
                Tab(
                  child: Text('مهامي '),
                ),
                Tab(
                  text: 'مفكرتي',
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              CalenderView(),
              TaskView(),
            ],
          ),
        ),
      ),
    );
  }
}
