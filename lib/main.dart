import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/bloc/notes_bloc.dart';
import 'package:organize_me/constants.dart';
import 'package:organize_me/database/db.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/bills_listview.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/doctors_numbers.dart';
import 'package:organize_me/scrns_and_widgets/notes_section/note_view.dart';
import 'package:organize_me/scrns_and_widgets/scheduling_dates_section/appoitments_calendar.dart';
import 'package:organize_me/scrns_and_widgets/scheduling_dates_section/cubit/appoitment_cubit.dart';
import 'package:organize_me/scrns_and_widgets/task_section/task_view.dart';
import 'package:organize_me/services/local_notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotificationService.inite();
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
        theme: ThemeData(
          brightness: Brightness.light,
        ),
        home: DefaultTabController(
          length: 5,
          child: Scaffold(
              appBar: AppBar(
                bottomOpacity: 0.7,
                bottom: const TabBar(
                  // tabAlignment: TabAlignment.center,

                  tabs: [
                    Tab(
                      icon: Icon(Icons.task_alt_outlined),
                    ),
                    Tab(
                      icon: Icon(Icons.calendar_month),
                    ),
                    Tab(
                      icon: Icon(Icons.note_alt),
                    ),
                    Tab(
                      icon: Icon(Icons.payments),
                    ),
                    Tab(
                      icon: Icon(Icons.medical_information_outlined),
                    ),
                  ],
                ),
                title: const Text(
                  'OrganizeMe',
                  style: TextStyle(color: deepPurple),
                ),
                actions: const [
                  IconButton(
                      onPressed: null, icon: Icon(Icons.wb_sunny_outlined)),
                  IconButton(
                      onPressed: null,
                      icon: Icon(Icons.energy_savings_leaf_outlined))
                ],
              ),
              body: TabBarView(children: [
                const DayCalendar(),
                BlocProvider<AppoitmentCubit>(
                  create: (context) => AppoitmentCubit(),
                  child: const MonthCalendar(),
                ),
                const NoteView(),
                const BillsListView(),
                const MedsAndDocs()
              ])),
        ));
  }
}
