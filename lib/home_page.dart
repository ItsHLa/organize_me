import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/settings.dart';

import 'constants.dart';
import 'customize_app_cubit/customize_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

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
            endDrawer: Settings(),
            //drawer: Settings(),
            appBar: AppBar(
              title: const Text(
                'Hi , there!',
                style: TextStyle(color: deepPurple),
              ),
              actions: [
                Builder(builder: (context) {
                  return IconButton(
                      onPressed: () {
                        Scaffold.of(context).openEndDrawer();
                      },
                      icon: const Icon(Icons.settings));
                }),
              ],
            ),
            bottomNavigationBar: CircularBottomNavigation(
              barBackgroundColor:
              state is CustomizeDarkModeOn ? black : Colors.white,
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
