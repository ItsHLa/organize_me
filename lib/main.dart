import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/bloc/notes_bloc.dart';
import 'package:organize_me/database/db.dart';
import 'package:organize_me/scrns_and_widgets/my_drawer.dart';
import 'package:organize_me/scrns_and_widgets/notes_section/note_view.dart';
import 'package:organize_me/scrns_and_widgets/task_section/task_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NotesBloc()),
      ],
      child: const MaterialApp(
        home: OrganizeMe(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class OrganizeMe extends StatefulWidget {
  const OrganizeMe({super.key});

  @override
  State<OrganizeMe> createState() => _OrganizeMeState();
}

class _OrganizeMeState extends State<OrganizeMe> {
  List pages = [const TaskView(), const NoteView()];
  int pageIndex = 0;

  void _getAllNotes() async {
    BlocProvider.of<NotesBloc>(context).notes =
        await DatabaseHelper.getAllNotes();
  }

  @override
  void initState() {
    DatabaseHelper.intialDb();
    _getAllNotes();
    super.initState();
  }

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
