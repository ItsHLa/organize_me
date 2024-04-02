import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:organize_me/scrns_and_widgets/scheduling_dates_section/widgets/month_view.dart';

import 'add_date_scrn.dart';

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
        floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
        floatingActionButton:  FloatingActionButton.small(
          onPressed: ()  {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddTaskScrn(),));
          },
          shape: const StadiumBorder(),
          child: const Icon(Icons.add),
        )
      ,
        body: Container(
          padding: const EdgeInsets.only(
            top: 5,
            bottom: 8,
            left: 5,
            right: 5,
          ),
          child: const MonthCalender(),
        ),
      ),
    );
  }
}
