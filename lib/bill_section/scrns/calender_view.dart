import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:organize_me/bill_section/widget/input_event.dart';

import '../widget/month_view.dart';

class CalenderView extends StatefulWidget {
  const CalenderView({super.key});

  @override
  State<CalenderView> createState() => _CalenderViewState();
}

class _CalenderViewState extends State<CalenderView> {
  final List pages = [const InputEvent(), const MonthCalender()];
  int i = 0;
  @override
  Widget build(BuildContext context) {
    return CalendarControllerProvider(
        controller: EventController(),
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
                    icon: Icon(Icons.add), label: 'حدث جديد'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.calendar_month_outlined), label: 'شهر '),
              ],
            ),
            body: pages[i]));
  }
}
