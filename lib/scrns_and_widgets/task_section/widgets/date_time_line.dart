import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';

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
      firstDate: DateTime(2024),
      lastDate: DateTime(3000),
      focusDate: widget.focusDate,
      controller: _controller,
      showTimelineHeader: false,
      dayProps: const EasyDayProps(width: 65, height: 65),
      onDateChange: widget.onDateChange,
    );
  }
}
