import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/constants.dart';
import 'package:organize_me/scrns_and_widgets/task_section/cubit/task_cubit.dart';

class TaskDetails extends StatelessWidget {
  const TaskDetails(
      {super.key,
      this.onPressedEdit,
      this.onPressedDelete,
      required this.index});

  final void Function()? onPressedEdit;
  final void Function()? onPressedDelete;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: onPressedEdit, child: const Text('تعديل')),
          TextButton(onPressed: onPressedDelete, child: const Text('حذف')),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            color: Colors.cyanAccent, borderRadius: BorderRadius.circular(20)),
        margin: const EdgeInsets.only(bottom: 50, top: 50, left: 8, right: 8),
        padding: const EdgeInsets.all(15),
        child: BlocBuilder<TaskCubit, TaskState>(
          builder: (context, state) {
            return Column(
              children: [
                ListTile(
                  leading: taskPending,
                  title: Text(
                    state.tasks[index].title,
                  ),
                  // subtitle: Text('''${state.tasks[index].startTime} \n''',
                  //   style: const TextStyle(fontSize: 15 )),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 155,
                      child: TaskInfo(
                          title: 'تاريخ البدء',
                          text: state.tasks[index].startDate),
                    ),
                    SizedBox(
                      width: 155,
                      child: TaskInfo(
                          title: 'توقيت البدء',
                          text: state.tasks[index].startTime),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                TaskInfo(title: 'الحالة', text: state.tasks[index].status),
                const SizedBox(
                  height: 5,
                ),
                TaskInfo(
                  title: 'الوصف',
                  text: state.tasks[index].content,
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

class FontStyleDetailsPage extends StatelessWidget {
  const FontStyleDetailsPage({
    super.key,
    required this.title,
    required this.text,
  });

  final String title;

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(width: 10),
        Text(
          text,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}

class TaskInfo extends StatelessWidget {
  const TaskInfo({super.key, required this.text, required this.title});

  final String text;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Container(
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.black54)),
        child: SingleChildScrollView(
          child: Text(text, style: const TextStyle(fontSize: 15)),
        ),
      ),
    );
  }
}
