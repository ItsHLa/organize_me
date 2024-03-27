import 'package:flutter/material.dart';
import 'package:organize_me/bill_section/scrns/calender_view.dart';
import 'package:organize_me/task_section/scrns/task_view.dart';

import 'bill_section/widget/my_drawer.dart';

void main() {
  runApp(const OrganizeMe());
}

class OrganizeMe extends StatefulWidget {
  const OrganizeMe({super.key});

  @override
  State<OrganizeMe> createState() => _OrganizeMeState();
}

class _OrganizeMeState extends State<OrganizeMe> {

  List pages = const [CalenderView() , TaskView(), MyDrawer()];
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          onTap: (value) { setState(() {
            pageIndex = value ;
          });},
          currentIndex: pageIndex ,
          items:const  [
            BottomNavigationBarItem(icon: Icon(Icons.calendar_month) , label: 'تقويم'),
            BottomNavigationBarItem(icon: Icon(Icons.edit_note) , label: 'مفكرة'),
            BottomNavigationBarItem(icon: Icon(Icons.info_outline) , label: 'مدفوعات'),
          ],
        ),
        body:pages[pageIndex]
        ),
    );
  }
}
