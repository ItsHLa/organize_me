import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/bills_view.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/docs_number_section/cubit/docs_num_cubit.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/docs_number_section/doctors_numbers.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/medicien_section/cubit/medicien_cubit.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/medicien_section/meds_page.dart';
import 'package:organize_me/scrns_and_widgets/notes_section/note_view.dart';
import 'package:organize_me/scrns_and_widgets/task_section/cubit/task_cubit.dart';
import 'package:organize_me/scrns_and_widgets/task_section/task_view.dart';

import 'constants.dart';
import 'dark_mode_cubit/dark_mode_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TabItem> tabItems = List.of([
    TabItem(
      Icons.task_alt_outlined,
      "مهام",
      deepPurple,
    ),
    TabItem(
      Icons.note_alt,
      " مفكرة",
      deepPurple,
    ),
    TabItem(
      Icons.payments,
      "فواتير",
      deepPurple,
    ),
    TabItem(Icons.phone, "اطباء", deepPurple),
    TabItem(Icons.medication, "ادوية", deepPurple),
  ]);

  int pageIndex = 0;

  List pages = [
    BlocProvider<TaskCubit>(
        create: (context) => TaskCubit(), child: const DayCalendar()),
    NoteView(),
    MyBills(),
    BlocProvider(
        create: (context) => DocsNumCubit(), child: const MedsAndDocs()),
    BlocProvider<MedicienCubit>(
      create: (context) => MedicienCubit(),
      child: const MedsPage(),
    )
  ];
  final CircularBottomNavigationController _navigationController =
      CircularBottomNavigationController(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'OrganizeMe',
            style: TextStyle(color: deepPurple),
          ),
          actions: [
            BlocBuilder<DarkModeCubit, DarkModeState>(
              builder: (context, state) {
                return IconButton(
                  onPressed: () {
                    BlocProvider.of<DarkModeCubit>(context).darkModeIsOn();
                  },
                  icon: state.icon,
                );
              },
            ),
            const IconButton(
              onPressed: null,
              icon: Icon(
                Icons.energy_savings_leaf_outlined,
              ),
            )
          ],
        ),
        bottomNavigationBar: BlocBuilder<DarkModeCubit, DarkModeState>(
          builder: (context, state) {
            return CircularBottomNavigation(
              barBackgroundColor:
                  state is DarkModeOn ? Colors.black87 : Colors.white,
              circleSize: 40,
              iconsSize: 20,
              controller: _navigationController,
              tabItems,
              //selectedPos: pageIndex,
              selectedCallback: (idx) {
                setState(() {
                  pageIndex = idx!;
                  _navigationController.value = idx!;
                });
              },
            );
          },
        ),
        body: pages[pageIndex]);
  }
}
