import 'package:flutter/material.dart';
import 'package:organize_me/scrns_and_widgets/task_section/widgets/task_item.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../../constants.dart';

class MyTimeLine extends StatelessWidget {
  const MyTimeLine({
    super.key,
    required this.taskTitle,
    required this.taskContent,
    this.taskTag,
    required this.startTime,
    required this.endTime,
    this.onPressedEdit,
    this.onPressedDelete,
    // required this.task2Type,
    // required this.task2Description,
    // this.onPressedtask2,
  });

  final String taskTitle;
  final String taskContent;
  final String? taskTag;
  final String startTime;
  final String endTime;
  final void Function()? onPressedEdit;
  final void Function()? onPressedDelete;

  // final String task2Type;
  // final String task2Description;
  // final void Function()? onPressedtask2;

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
              color: deepPurple,
              iconStyle: IconStyle(
                color: Colors.white54,
                iconData: Icons.task_alt_outlined,
              ),
            ),
            endChild: TaskItem(
              TaskStartTime: startTime,
              TaskEndTime: endTime,
              onPressedDelete: onPressedDelete,
              onPressedEdit: onPressedEdit,
              taskTitle: taskTitle,
              taskContent: taskContent,
              taskTag: taskTag,
            )),
       /* const TimelineDivider(
          begin: 0.1,
          end: 0.9,
          thickness: 6,
          color: deepPurple,
        ),*/
        // TimelineTile(
        //     lineXY: 0.9,
        //     alignment: TimelineAlign.manual,
        //     afterLineStyle: const LineStyle(color: deepPurple),
        //     beforeLineStyle: const LineStyle(color: deepPurple),
        //     indicatorStyle: IndicatorStyle(
        //       width: 25,
        //       color: deepPurple,
        //       iconStyle: IconStyle(
        //         color: Colors.white54,
        //         iconData: Icons.task_alt_outlined,
        //       ),
        //     ),
        //     startChild: TaskItem(
        //       onPressed: onPressedtask2,
        //       taskType: task2Type,
        //       description: task2Description,
        //     )),
        // const TimelineDivider(
        //   begin: 0.1,
        //   end: 0.9,
        //   thickness: 6,
        //   color: deepPurple,
        // ),
      ],
    );
  }
}
