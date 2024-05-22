import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'constants.dart';
import 'dark_mode_cubit/dark_mode_cubit.dart';
import 'user.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    User.userInfo().then(
      (userInfo) => me = User(
        id: userInfo['id'],
        username: userInfo['username'],
        email: userInfo['email'],
        password: userInfo['password'],
      ),
    );
  }

  int pageIndex = 0;
  var pages = [
    taskPage,
    billsPage,
    medsPage,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'OrganizeMe',
          style: TextStyle(color: appColorTheme),
        ),
        actions: [
          BlocBuilder<DarkModeCubit, DarkModeState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () {
                  BlocProvider.of<DarkModeCubit>(context).darkModeIsOn();
                },
                icon: state.on ? darkModeOn : darkModeOff,
              );
            },
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => accountInfo,
              ));
            },
            icon: const Icon(Icons.account_circle_outlined),
          )
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
            icon: Icon(Icons.task_alt_outlined),
            label: 'المهام',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payments),
            label: 'الفواتير',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_information_outlined),
            label: 'الادوية',
          ),
        ],
      ),
      body: pages[pageIndex],
    );
  }
}
