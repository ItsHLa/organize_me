import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';

class DailyTasks extends StatefulWidget {
  const DailyTasks({super.key});

  @override
  State<DailyTasks> createState() => _DailyTasksState();
}

class _DailyTasksState extends State<DailyTasks> {
  @override
  Widget build(BuildContext context) {
    return CalendarControllerProvider(
        controller: EventController(),
        child: DayView(
            heightPerMinute: 1,
            timeLineWidth: 60,
            dayTitleBuilder: DayHeader.hidden));
  }
}
