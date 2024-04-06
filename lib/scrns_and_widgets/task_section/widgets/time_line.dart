import 'package:flutter/material.dart';
import 'package:organize_me/scrns_and_widgets/task_section/widgets/task_Item.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../../constants.dart';

class MyTimeLine extends StatelessWidget {
  const MyTimeLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TimelineTile(
            lineXY: 0.1,
            alignment: TimelineAlign.manual,
            afterLineStyle: LineStyle(color: deepPurple),
            beforeLineStyle: LineStyle(color: deepPurple),
            indicatorStyle: IndicatorStyle(
              width: 25,
              color: deepPurple,
              iconStyle: IconStyle(
                  color: Colors.white54, iconData: Icons.task_alt_outlined),
            ),
            endChild: TaskItem()),
        const TimelineDivider(
          begin: 0.1,
          end: 0.9,
          color: deepPurple,
        ),
        TimelineTile(
            lineXY: 0.9,
            alignment: TimelineAlign.manual,
            afterLineStyle: LineStyle(color: deepPurple),
            beforeLineStyle: LineStyle(color: deepPurple),
            indicatorStyle: IndicatorStyle(
              width: 25,
              color: deepPurple,
              iconStyle: IconStyle(
                  color: Colors.white54, iconData: Icons.task_alt_outlined),
            ),
            startChild: TaskItem()),
        const TimelineDivider(
          begin: 0.1,
          end: 0.9,
          color: deepPurple,
        ),
      ],
    );
  }
}
