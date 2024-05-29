import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/constants.dart';
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
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: widget.tasks.length,
          itemBuilder: (context, index) {
            return TaskItem(
              cancelIcon: const Icon(Icons.cancel_outlined),
              onCancelIconPressed: () {
                BlocProvider.of<TaskCubit>(context)
                    .deleteTask(widget.tasks[index].id);
              },
              statusIcon: state.tasks[index].status == 'متوقف'
                  ? taskPending
                  : (state.tasks[index].status == 'قيد تنفيذ'
                      ? taskOngoing
                      : taskComplete),
              date: widget.tasks[index].startDate,
              onStatusIconPressed: () {
                if (state.tasks[index].status == 'متوقف') {
                  BlocProvider.of<TaskCubit>(context).editStatus(
                    id: widget.tasks[index].id,
                    status: 'قيد تنفيذ',
                  );
                }
                if (widget.tasks[index].status == 'قيد تنفيذ') {
                  BlocProvider.of<TaskCubit>(context).editStatus(
                    id: widget.tasks[index].id,
                    status: 'اكتملت',
                  );
                }
              },
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (newcontext) => BlocProvider<TaskCubit>.value(
                    value: BlocProvider.of(context),
                    child: TaskDetails(
                      index: index,
                      onPressedEdit: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          isDismissible: true,
                          context: context,
                          builder: (newcontext) =>
                              BlocProvider<TaskCubit>.value(
                            value: BlocProvider.of(context),
                            child: EditTask(task: widget.tasks[index]),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
              taskStartTime: widget.tasks[index].startTime,
              taskTitle: widget.tasks[index].title,
              taskPreAlarm: widget.tasks[index].preAlarm,
            );
          },
        );
      },
    );
  }
}
