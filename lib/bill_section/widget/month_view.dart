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

String whichMonth (int month){
  switch (month) {
    case 1:
      return 'Jan';
    case 2:
      return 'Feb';
    case 3:
      return 'Mar';
    case 4:
      return 'Apr';
    case 5:
      return 'May';
    case 6:
      return 'Jun';
    case 7:
      return 'Jul';
    case 8:
      return 'Aug';
    case 9 :
      return 'Sep';
    case 10:
      return 'Oct' ;
    case 11:
      return 'Nov';
    case 12:
      return 'Dec';  
    default:
      return '';
  }
}

class MonthCalender extends StatelessWidget {
  const MonthCalender({super.key});

  @override
  Widget build(BuildContext context) {
    return MonthView(
      cellAspectRatio: 0.8,
      borderColor: Colors.white10,
      headerBuilder: (date) => Container(
        decoration: const BoxDecoration(
          color: indigo
        ),
          alignment: Alignment.center,
          child:Text('${whichMonth(date.month)} - ${date.year.toString()}')),
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
