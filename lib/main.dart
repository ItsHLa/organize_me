import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:organize_me/scrns_and_widgets/bill_section/scrns/calender_view.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/widget/my_drawer.dart';
import 'package:organize_me/scrns_and_widgets/notes_section/scrns/note_view.dart';
=======
import 'package:organize_me/scrns_and_widgets/my_drawer.dart';
import 'package:organize_me/scrns_and_widgets/notes_section/note_view.dart';
import 'package:organize_me/scrns_and_widgets/task_section/task_view.dart';
>>>>>>> 328cb563f6df3866d8bc62b839b1d78f56ce7e7f

void main() {
  runApp(const OrganizeMe());
}

class OrganizeMe extends StatefulWidget {
  const OrganizeMe({super.key});

  @override
  State<OrganizeMe> createState() => _OrganizeMeState();
}

class _OrganizeMeState extends State<OrganizeMe> {
<<<<<<< HEAD
  List pages = [
    CalendarControllerProvider(
      controller: EventController(),
      child: const CalenderView(),
    ),
    const NoteView(),
  ];
=======

  List pages = [const TaskView(), const NoteView()];
>>>>>>> 328cb563f6df3866d8bc62b839b1d78f56ce7e7f
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
<<<<<<< HEAD
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (value) {
              setState(() {
                pageIndex = value;
              });
            },
            currentIndex: pageIndex,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_month), label: 'تقويم'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.edit_note), label: 'مفكرة'),
            ],
          ),
          body: pages[pageIndex]),
=======
        ),

        bottomNavigationBar: BottomNavigationBar(
          onTap: (value) { setState(() {
            pageIndex = value ;
          });},
          currentIndex: pageIndex ,

          items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.checklist_outlined), label: 'المهام'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.edit_note), label: 'مفكرة'),
            ],
        ),
        body: pages[pageIndex]
        ),
>>>>>>> 328cb563f6df3866d8bc62b839b1d78f56ce7e7f
    );
  }
}
