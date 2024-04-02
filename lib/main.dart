import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/widget/my_drawer.dart';
import 'package:organize_me/scrns_and_widgets/notes_section/note_view.dart';
import 'package:organize_me/scrns_and_widgets/scheduling_dates_section/calender_view.dart';

void main() {
  runApp(const OrganizeMe());
}

class OrganizeMe extends StatefulWidget {
  const OrganizeMe({super.key});

  @override
  State<OrganizeMe> createState() => _OrganizeMeState();
}

class _OrganizeMeState extends State<OrganizeMe> {

  List pages =  [
    CalendarControllerProvider(
      controller: EventController(),
      child: const  CalenderView()) , const NoteView()];
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: Scaffold(
        drawer: const MyDrawer(),
        appBar: AppBar(
          title: const Text('OrganizeMe'),
        ),

        bottomNavigationBar: BottomNavigationBar(
          onTap: (value) { setState(() {
            pageIndex = value ;
          });},
          currentIndex: pageIndex ,

          items:const  [
            BottomNavigationBarItem(icon: Icon(Icons.calendar_month) , label: 'تقويم'),
            BottomNavigationBarItem(icon: Icon(Icons.edit_note) , label: 'مفكرة'),
          ],
        ),
        body: pages[pageIndex]
        ),
    );
  }
}
