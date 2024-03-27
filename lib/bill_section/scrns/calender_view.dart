import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:organize_me/bill_section/widget/input_event.dart';

import '../widget/month_view.dart';

class CalenderView extends StatefulWidget {
  const CalenderView({super.key});

  @override
  State<CalenderView> createState() => _CalenderViewState();
}

class _CalenderViewState extends State<CalenderView> {
  @override
  Widget build(BuildContext context) {
    return CalendarControllerProvider(
        controller: EventController(),
<<<<<<< HEAD
        child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: i,
              onTap: (value) {
                setState(() {
                  i = value;
                });
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_month_outlined),
                  label: ' شهر ',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add),
                  label: ' حدث جديد',
                ),
              ],
            ),
            body: pages[i]));
=======
        child:  Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
          floatingActionButton:const  FloatingActionButton.small(
          onPressed: null, shape: const StadiumBorder(),
           child:   Icon(Icons.add),
                      ),
            body: Container(
              padding: const EdgeInsets.only(top : 5 , bottom:  8 , left: 5, right: 5),
                child: const MonthCalender()),));
>>>>>>> cfc806a0c9d29ee13ec47874c34dccdceb7e6f2c
  }
}
