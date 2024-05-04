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
  var pages = [taskPage, billsPage, medsPage, accountInfo];

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CustomizeCubit>(context).getAllCustomization();
    return Scaffold(
        endDrawer: const Settings(),
        appBar: AppBar(
          title: Text(
            'Organize Me',
            style: TextStyle(color: appColorTheme),
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
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.grey,
          selectedItemColor: appColorTheme,
          onTap: (value) {
            setState(() {
              pageIndex = value;
            });
          },
          currentIndex: pageIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.task_alt_outlined), label: 'المهام'),
            BottomNavigationBarItem(
                icon: Icon(Icons.payments), label: 'الفواتير'),
            BottomNavigationBarItem(
                icon: Icon(Icons.medical_information_outlined),
                label: 'الادوية'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outlined), label: 'حساب')
          ],
        ),
        body: pages[pageIndex]);
  }
}

