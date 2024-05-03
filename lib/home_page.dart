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

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CustomizeCubit>(context).getAllCustomization();
    return BlocBuilder<CustomizeCubit, CustomizeState>(
      builder: (context, state) {
        return Scaffold(
            endDrawer: const Settings(),
            appBar: AppBar(
              title: Text(
                'Organize Me',
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
            bottomNavigationBar: BottomNavigationBar(
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
                    label: 'الادوية')
              ],
            ),
            body: state.pages[pageIndex]);
      },
    );
  }
}

