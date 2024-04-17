import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../../constants.dart';

class MyTimeLine extends StatelessWidget {
  const MyTimeLine({
    super.key,
    required this.taskTitle,
    required this.taskContent,
    required this.startTime,
    required this.endTime,
    this.onPressedEdit,
    this.onPressedDelete,
    this.onTap,
    required this.date,
  });

  final String taskTitle;
  final String taskContent;
  final String startTime;
  final String endTime;
  final String date;
  final void Function()? onPressedEdit;
  final void Function()? onPressedDelete;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TimelineTile(
          lineXY: 0.1,
          alignment: TimelineAlign.manual,
          afterLineStyle: const LineStyle(color: deepPurple),
          beforeLineStyle: const LineStyle(color: deepPurple),
          indicatorStyle: IndicatorStyle(
            width: 25,
            color: Colors.grey,
            iconStyle: IconStyle(
              color: Colors.white54,
              iconData: Icons.task_alt_outlined,
            ),
          ),
          // endChild: //TaskItem(
          //onTap: onTap,
          // taskStartTime: startTime,
          //taskEndTime: endTime,
          //onPressedDelete: onPressedDelete,
          //onPressedEdit: onPressedEdit,
          // taskTitle: taskTitle,
          // date : date
          // ),
        ),
      ],
    );
  }
}
