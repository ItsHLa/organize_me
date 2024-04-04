import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'event_item.dart';
import 'my_cell_calendar.dart';
import 'my_header_calendar.dart';
import 'my_week_calendar.dart';

class MonthCalender extends StatelessWidget {
  const MonthCalender({super.key});

  @override
  Widget build(BuildContext context) {
    return MonthView(
      cellAspectRatio: 0.8,
      borderColor: Colors.white10,
      headerBuilder: (date) => MyHeader(
        date: date,
      ),
      weekDayBuilder: (day) => MyWeek(day: day),
      cellBuilder: (
        date,
        event,
        isToday,
        isInMonth,
      ) {
        return MyCell(
          date: date,
          isToday: isToday,
          isInMonth: isInMonth,
        );
      },
      controller: EventController(),
      onCellTap: (events, date) {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
                padding: const EdgeInsets.all(8),
                alignment: Alignment.center,
                child: const Column(
                  children: [Text('events '), Expanded(child: EventItem())],
                ));
          },
        );
      },
      headerStyle: const HeaderStyle(
        decoration: BoxDecoration(
          color: indigo,
        ),
      ),
    );
  }
}
