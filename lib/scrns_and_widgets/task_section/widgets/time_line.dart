import 'package:flutter/material.dart';
import 'package:organize_me/scrns_and_widgets/task_section/widgets/task_item.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../../constants.dart';

class MyTimeLine extends StatelessWidget {
  const MyTimeLine({super.key, required this.value, this.onChange});

  final bool value;
  final void Function(bool?)? onChange;

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
              value: value,
              onChange: onChange,
            )),
        const TimelineDivider(
          begin: 0.1,
          end: 0.9,
          thickness: 6,
          color: deepPurple,
        ),
        TimelineTile(
            lineXY: 0.9,
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
            startChild: TaskItem(
              value: value,
              onChange: onChange,
            )),
        const TimelineDivider(
          begin: 0.1,
          end: 0.9,
          thickness: 6,
          color: deepPurple,
        ),
      ],
    );
  }
}
