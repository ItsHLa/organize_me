import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:organize_me/constants.dart';

class MyDateTimeLine extends StatefulWidget {
  const MyDateTimeLine({super.key, this.onDateChange, required this.focusDate});

  final void Function(DateTime)? onDateChange;
  final DateTime focusDate;

  @override
  State<MyDateTimeLine> createState() => _MyDateTimeLineState();
}

class _MyDateTimeLineState extends State<MyDateTimeLine> {
  final EasyInfiniteDateTimelineController _controller =
      EasyInfiniteDateTimelineController();

  @override
  Widget build(BuildContext context) {
    return EasyInfiniteDateTimeLine(
      activeColor: appColorTheme,
      firstDate: DateTime(2024),
      lastDate: DateTime(3000),
      focusDate: widget.focusDate,
      itemBuilder:
          (context, dayNumber, dayName, monthName, fullDate, isSelected) {
        return Container(
          decoration: BoxDecoration(
              color: (fullDate.year == DateTime.now().year &&
                      fullDate.month == DateTime.now().month &&
                      fullDate.day == DateTime.now().day)
                  ? appColorTheme
                  : null,
              borderRadius: BorderRadius.circular(20),
              border:
                  Border.all(color: isSelected ? appColorTheme : Colors.grey)),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 2,
                ),
                Text(
                  monthName,
                  style: const TextStyle(fontSize: 12),
                ),
                Text(
                  dayNumber,
                  style: const TextStyle(fontSize: 12),
                ),
                Text(
                  dayName,
                  style: const TextStyle(fontSize: 12),
                ),
                const SizedBox(
                  height: 2,
                ),
              ],
            ),
          ),
        );
      },
      controller: _controller,
      showTimelineHeader: false,
      dayProps: const EasyDayProps(width: 65, height: 65),
      onDateChange: widget.onDateChange,
    );
  }
}
