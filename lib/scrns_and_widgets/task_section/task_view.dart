import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class DayCalendar extends StatelessWidget {
  const DayCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfCalendar(
        view: CalendarView.day,
        showCurrentTimeIndicator: true,
        showDatePickerButton: true,
        showNavigationArrow: true,
        allowAppointmentResize: true,
        allowDragAndDrop: true,
      ),
    );
  }
}
