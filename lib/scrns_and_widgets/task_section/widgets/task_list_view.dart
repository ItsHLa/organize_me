import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/task_section/cubit/task_cubit.dart';
import 'package:organize_me/scrns_and_widgets/task_section/models/task.dart';
import 'package:organize_me/scrns_and_widgets/task_section/widgets/time_line.dart';

import '../edit_task_scrn.dart';

class TaskListView extends StatelessWidget {
  const TaskListView({super.key, required this.tasks});

  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return MyTimeLine(
          startTime: tasks[index].startTime,
          endTime: tasks[index].endTime,
          onPressedEdit: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (newcontext) => BlocProvider<TaskCubit>.value(
                value: BlocProvider.of(context),
                child: EditTaskScrn(task: tasks[index]),
              ),
            );
          },
          onPressedDelete: () {
            BlocProvider.of<TaskCubit>(context).deleteTask(tasks[index].id);
          },
          taskTitle: tasks[index].title,
          taskContent: tasks[index].content,
          taskTag: tasks[index].tag,
        );
      },
    );
  }
}
