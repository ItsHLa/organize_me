import 'package:flutter/material.dart';

class MyWeek extends StatelessWidget {
  const MyWeek({super.key, required this.day});
  final int day;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(7),
      alignment: Alignment.center,
      child: Text(dayInWeek(day)),
    );
  }

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

}