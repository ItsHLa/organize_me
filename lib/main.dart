import 'package:flutter/material.dart';
import 'package:organize_me/scrns_and_widgets/my_drawer.dart';
import 'package:organize_me/scrns_and_widgets/notes_section/note_view.dart';
import 'package:organize_me/scrns_and_widgets/task_section/task_view.dart';
import 'package:organize_me/services/local_notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotificationService.inite();
  runApp(const OrganizeMe());
}

class OrganizeMe extends StatefulWidget {
  const OrganizeMe({super.key});

  @override
  State<OrganizeMe> createState() => _OrganizeMeState();
}

class _OrganizeMeState extends State<OrganizeMe> {
  List pages = [const TaskView(), const NoteView()];
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
            onTap: (value) {
              setState(() {
                pageIndex = value;
              });
            },
            currentIndex: pageIndex,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.checklist_outlined), label: 'المهام'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.edit_note), label: 'مفكرة'),
            ],
          ),
          body: pages[pageIndex]),
    );
  }
}
