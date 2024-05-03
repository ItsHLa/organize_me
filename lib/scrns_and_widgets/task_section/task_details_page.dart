import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/constants.dart';
import 'package:organize_me/scrns_and_widgets/task_section/cubit/task_cubit.dart';

class TaskDetails extends StatelessWidget {
  const TaskDetails({
    super.key,
    this.onPressedEdit,
    required this.index,
  });

  final void Function()? onPressedEdit;
  final int index;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          return Column(
            children: [
              Center(
                child: ListTile(
                  trailing: IconButton(
                      onPressed: onPressedEdit,
                      iconSize: 20,
                      icon: const Icon(Icons.mode_edit_outlined)),
                  leading: state.tasks[index].status == 'متوقف'
                      ? taskPending
                      : (state.tasks[index].status == 'قيد تنفيذ'
                          ? taskOngoing
                          : taskComplete),
                  subtitle: Text(
                    '${state.tasks[index].startDate} -  ${state.tasks[index].startTime}',
                  ),
                  title: Text(
                    state.tasks[index].title,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              const Divider(),
              TaskInfo(
                text: state.tasks[index].content,
              ),
              const SizedBox(
                height: 40,
              )
            ],
          );
        },
      ),
    );
  }
}

class TaskInfo extends StatelessWidget {
  const TaskInfo({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        subtitle: SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(7),
        child: Text(
          text,
          style: const TextStyle(fontSize: 15),
        ),
      ),
    ));
  }
}
