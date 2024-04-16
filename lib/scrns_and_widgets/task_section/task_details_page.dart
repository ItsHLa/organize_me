import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(9.0),
        child: Container(
          padding: const EdgeInsets.all(8),
          child: BlocBuilder<TaskCubit, TaskState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Text(
                          state.tasks[index].title,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        Text(state.tasks[index].startTime,
                            style: const TextStyle(fontSize: 18)),
                      ],
                    ),
                  ),
                  FontStyleDetailsPage(
                      title: 'الحالة', text: state.tasks[index].status),
                  const SizedBox(
                    height: 5,
                  ),
                  FontStyleDetailsPage(
                      title: 'التاريخ', text: state.tasks[index].startDate),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.black54)),
                    child: const Text('الوصف',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        Text(
                          state.tasks[index].content,
                          style: const TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  )
                ],
              );
            },
          ),
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
        Container(
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.black54)),
          child: Text(title,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        ),
        const SizedBox(width: 10),
        Text(
          text,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
