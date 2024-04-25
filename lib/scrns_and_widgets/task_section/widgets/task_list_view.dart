import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/task_section/cubit/task_cubit.dart';
import 'package:organize_me/scrns_and_widgets/task_section/models/task.dart';
import 'package:organize_me/scrns_and_widgets/task_section/widgets/task_item.dart';

import '../edit_task_screen.dart';
import '../task_details_page.dart';

class TaskListView extends StatefulWidget {
  const TaskListView({super.key, required this.tasks});

  final List<Task> tasks;

  @override
  State<TaskListView> createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  String status = '';

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: widget.tasks.length,
      itemBuilder: (context, index) {
        return TaskItem(
          date: widget.tasks[index].startDate,
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (newContext) => BlocProvider<TaskCubit>.value(
                      value: BlocProvider.of(context),
                      child: BlocListener<TaskCubit, TaskState>(
                        listener: (context, state) {
                          if (state is DeleteTaskSuccess) {
                            Navigator.of(context).pop();
                          }
                        },
                        child: TaskDetails(
                          onSelected: (value) {
                            setState(() {
                              status = value!;
                            });
                          },
                          index: index,
                          onPressedEdit: () {
                            showModalBottomSheet(
                                isScrollControlled: true,
                                isDismissible: true,
                                showDragHandle: true,
                                context: context,
                                builder: (newcontext) =>
                                    BlocProvider<TaskCubit>.value(
                                      value: BlocProvider.of(context),
                                      child:
                                          EditTask(task: widget.tasks[index]),
                                    ));
                          },
                          onPressedDelete: () {
                            BlocProvider.of<TaskCubit>(context)
                                .deleteTask(widget.tasks[index].id, context);
                          },
                          initialSelection: status,
                        ),
                      ),
                    )));
          },
          taskStartTime: widget.tasks[index].startTime,
          taskTitle: widget.tasks[index].title,
          taskPreAlarm: widget.tasks[index].preAlarm,
        );
      },
    );
  }
}
