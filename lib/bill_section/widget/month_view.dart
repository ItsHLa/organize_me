import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

String dayInWeek(int day) {
  switch (day) {
    case 0:
      return 'Mon';
    case 1:
      return 'Tue';
    case 2:
      return 'Wed';
    case 3:
      return 'Thu';
    case 4:
      return 'Fri';
    case 5:
      return 'Sat';
    case 6:
      return 'Sun';
    default:
      return '';
  }
}

Color checkIfToday(bool isToday) {
  if (isToday) {
    return indigo;
  } else {
    return Colors.transparent;
  }
}

class MonthCalender extends StatelessWidget {
  const MonthCalender({super.key});

  @override
  Widget build(BuildContext context) {
    return MonthView(
      cellAspectRatio: 0.8,
      borderColor: Colors.white10,
      //headerBuilder: (date) => Container(child:Text(date.month.toString())),
      weekDayBuilder: (day) => Container(
        margin: const EdgeInsets.all(7),
        alignment: Alignment.center,
        child: Text(dayInWeek(day)),
      ),

      cellBuilder: (date, event, isToday, isInMonth) {
        return Column(
          children: [
            Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: checkIfToday(isToday),
                    borderRadius: BorderRadius.circular(16)),
                child: Text(date.day.toString())),
          ],
        );
      },
      onCellTap: (events, date) {
        showDialog(
          context: context,
          builder: (context) {
            return const SimpleDialog(children: [Text('events')]);
            //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
          },
        );
      },
      headerStyle: const HeaderStyle(
          decoration: BoxDecoration(
        color: indigo,
      )),
    );
  }
}
