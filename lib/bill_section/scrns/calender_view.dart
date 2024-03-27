import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';

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
        child: Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.endContained,
          floatingActionButton: const FloatingActionButton.small(
            onPressed: null,
            shape: StadiumBorder(),
            child: Icon(Icons.add),
          ),
          body: Container(
              padding:
                  const EdgeInsets.only(top: 5, bottom: 8, left: 5, right: 5),
              child: const MonthCalender()),
        ));
  }
}
