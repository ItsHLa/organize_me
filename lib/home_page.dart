import 'package:flutter/material.dart';
import 'package:organize_me/drawer.dart';

import 'constants.dart';
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
      endDrawer: MyDarwer(),
      appBar: AppBar(
        title: Text(
          'OrganizeMe',
          style: TextStyle(color: appColorTheme),
        ),
        actions: [
          // BlocBuilder<DarkModeCubit, DarkModeState>(
          //   builder: (context, state) {
          //     return IconButton(
          //       onPressed: () {
          //         BlocProvider.of<DarkModeCubit>(context).darkModeIsOn();
          //       },
          //       icon: state.on ? darkModeOn : darkModeOff,
          //     );
          //   },
          // ),
          // IconButton(
          //   onPressed: () {
          //     Navigator.of(context).push(MaterialPageRoute(
          //       builder: (context) => accountInfo,
          //     ));
          //   },
          //   icon: const Icon(
          //     Icons.info_outline,
          //   ),
          // )
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
