
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:organize_me/bill_section/widget/calender_view.dart';
import 'package:organize_me/task_section/scrns/task_view.dart';

import 'bill_section/scrns/bills_list.dart';
import 'bill_section/widget/my_drawer.dart';


void main() {
  runApp(const OrganizeMe());
}



class OrganizeMe extends StatelessWidget {
  const OrganizeMe({super.key});

  @override
  Widget build(BuildContext context) {
    return     MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          drawer: const MyDrawer(),
          appBar: AppBar(
                title: const Text('OrganizeMe',
                  style:  TextStyle(
                      fontWeight: FontWeight.normal ,
                    fontSize: 20
                  )
                  ,),
            bottom: const TabBar(tabs: [Tab(text: 'مهامي', ),
            Tab(child: Text(' فواتيري القادمة '),)],),
          ),
          body:const TabBarView(children: [
            TaskView(),
            CalenderView()
          ],),

        ),
      )
    );
  }
}





