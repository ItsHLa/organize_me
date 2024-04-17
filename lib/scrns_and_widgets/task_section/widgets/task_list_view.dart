import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/task_section/cubit/task_cubit.dart';
import 'package:organize_me/scrns_and_widgets/task_section/models/task.dart';
import 'package:organize_me/scrns_and_widgets/task_section/widgets/task_Item.dart';

import '../edit_task_screen.dart';
import '../task_details_page.dart';

class TaskListView extends StatelessWidget {
  const TaskListView({super.key, required this.tasks});

  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return TaskItem(
          date: tasks[index].startDate,
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (newcontext) => BlocProvider<TaskCubit>.value(
                      value: BlocProvider.of(context),
                      child: TaskDetails(
                        index: index,
                        onPressedEdit: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (modalcontext) =>
                                BlocProvider<TaskCubit>.value(
                              value: BlocProvider.of(context),
                              child: EditTask(task: tasks[index]),
                            ),
                          );
                        },
                        onPressedDelete: () {
                          BlocProvider.of<TaskCubit>(context)
                              .deleteTask(tasks[index].id, context);
                        },
                      ),
                    )));
          },
          taskStartTime: tasks[index].startTime,
          taskEndTime: tasks[index].endTime,
          taskTitle: tasks[index].title,
        );
      },
    );
  }
}
