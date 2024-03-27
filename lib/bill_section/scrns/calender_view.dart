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
  @override
  Widget build(BuildContext context) {
    return CalendarControllerProvider(
        controller: EventController(),
        child: const Scaffold(
          floatingActionButton: FloatingActionButton(
            shape: StadiumBorder(),
            child: const  Icon(Icons.add),
            onPressed: null,
          ),
            body: MonthCalender(),));
  }
}
