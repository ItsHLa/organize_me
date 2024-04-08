import 'package:flutter/material.dart';
import 'package:organize_me/scrns_and_widgets/task_section/widgets/task_item.dart';
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
          endChild: const TaskItem(),
        ),
      ],
    );
  }
}
