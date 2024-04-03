import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';

class TaskView extends StatelessWidget {
  const TaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CalendarControllerProvider(
      controller: EventController(),
      child: Scaffold(
        body: DayView(),
      ),
    ));
  }
}
