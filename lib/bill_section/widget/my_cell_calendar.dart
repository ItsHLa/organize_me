import 'package:flutter/material.dart';

import '../../constants.dart';

class MyCell extends StatelessWidget {
  const MyCell({
    super.key,
    required this.date,
    required this.isToday,
    required this.isInMonth,
  });

  final DateTime date;
  final bool isToday;
  final bool isInMonth;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(4),
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
                border: Border.all(color: checkIfToday(isToday), width: 2),
                borderRadius: BorderRadius.circular(16)),
            child: Text(
              date.day.toString(),
              style: TextStyle(color: dayNotInMon(isInMonth)),
            )),
      ],
    );
  }

  Color? dayNotInMon(bool isInMonth) {
    if (!isInMonth) {
      return Colors.grey;
    } else {
      return null;
    }
  }

  Color checkIfToday(bool isToday) {
    if (isToday) {
      return indigo;
    } else {
      return Colors.transparent;
    }
  }
}
