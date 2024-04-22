import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'constants.dart';
import 'customize_app_cubit/customize_cubit.dart';
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
    TabItem(Icons.medical_information_outlined, "ادوية", deepPurple),
  ]);

  int pageIndex = 0;
  bool taskAndNotes = true;
  bool bills = true;
  bool numAndMeds = true;

  final CircularBottomNavigationController _navigationController =
      CircularBottomNavigationController(0);

  @override
  Widget build(BuildContext context) {
    List pages = BlocProvider.of<CustomizeCubit>(context).getPages();
    return BlocBuilder<CustomizeCubit, CustomizeState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Hi , there!',
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
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (newcontext) =>
                          BlocProvider<CustomizeCubit>.value(
                        value: BlocProvider.of(context),
                        child: SimpleDialog(
                          children: [
                            SwitchListTile(
                              title: const Text('مهام و مفكرة'),
                              //  selected: taskAndNotes,
                              value: state.taskNotes,
                              onChanged: (value) {
                                setState(() {
                                  taskAndNotes = value;
                                });
                              },
                            ),
                            SwitchListTile(
                              title: const Text('فواتير'),
                              value: state.bill,
                              onChanged: (value) {
                                bills = value;
                              },
                            ),
                            SwitchListTile(
                              title: const Text('ارقام الاطباء و ادويتي'),
                              value: state.numMeds,
                              onChanged: (value) {
                                setState(() {
                                  numAndMeds = value;
                                });
                              },
                            ),
                            TextButton(
                                onPressed: () {
                                  BlocProvider.of<CustomizeCubit>(context)
                                      .customize(
                                          tasksAndNotes: taskAndNotes,
                                          bills: bills,
                                          docsAndNumber: numAndMeds);
                                  if (state is Customize) {
                                    Navigator.of(newcontext).pop();
                                  }
                                },
                                child: const Text(' موافق'))
                          ],
                        ),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.dashboard_customize_outlined,
                  ),
                )
              ],
            ),
            bottomNavigationBar: CircularBottomNavigation(
              barBackgroundColor:
                  state is DarkModeOn ? Colors.black87 : Colors.white,
              circleSize: 40,
              iconsSize: 20,
              controller: _navigationController,
              BlocProvider.of<CustomizeCubit>(context).getTabs(),
              //selectedPos: pageIndex,
              selectedCallback: (idx) {
                setState(() {
                  pageIndex = idx!;
                  _navigationController.value = idx;
                });
              },
            ),
            body: pages[pageIndex]);
      },
    );
  }
}
