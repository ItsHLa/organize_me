import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

import '../../constants.dart';


class CalenderView extends StatelessWidget {
  const CalenderView({super.key});

  @override
  Widget build(BuildContext context) {
    return CalendarControllerProvider(
        controller: EventController(),
        child: Scaffold(
          body: Container(
          padding: const EdgeInsets.all(8),
          child :  MonthView(
          cellAspectRatio: 0.8,
          onCellTap: (events, date) {
            showDialog(context: context, builder: (context) {
              return SimpleDialog(children: [Text('events')]);
              //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            },);
          },
          headerStyle: HeaderStyle(decoration: BoxDecoration(
            color: indigo,
          ))
          ,
        ),
      ),
    ) );
  }
}
