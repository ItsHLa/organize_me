import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/constants.dart';
import 'package:organize_me/scrns_and_widgets/task_section/cubit/task_cubit.dart';

class TaskDetails extends StatelessWidget {
  const TaskDetails({
    super.key,
    this.onPressedEdit,
    this.onPressedDelete,
    required this.index,
    required this.onSelected,
    required this.initialSelection,
  });

  final void Function()? onPressedEdit;
  final void Function()? onPressedDelete;
  final void Function(String?)? onSelected;
  final String? initialSelection;
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
      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          if (state is DeleteTaskSuccess &&
              BlocProvider.of<TaskCubit>(context).lastActionDelete) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pop();
            });
            BlocProvider.of<TaskCubit>(context).lastActionDelete = false;
            return Container();
          }
          return Container(
            margin: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: softDarkBlue,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: <Widget>[
                Column(
                  children: [
                    Center(
                      child: ListTile(
                        leading: taskPending,
                        title: Text(
                          state.tasks[index].title,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 170,
                          child: TaskInfo(
                            title: 'تاريخ البدء',
                            text: state.tasks[index].startDate,
                          ),
                        ),
                        SizedBox(
                          width: 170,
                          child: TaskInfo(
                            title: 'توقيت البدء',
                            text: state.tasks[index].startTime,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ListTile(
                        title: const Text(
                          'الحالة',
                          style: TextStyle(color: Colors.black),
                        ),
                        subtitle: DropdownMenu(
                          textStyle: const TextStyle(color: Colors.black),
                          inputDecorationTheme: InputDecorationTheme(
                              activeIndicatorBorder:
                                  const BorderSide(color: Colors.black),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(color: black),
                                borderRadius: BorderRadius.circular(16),
                              )),
                          initialSelection: state.tasks[index].status,
                          onSelected: onSelected,
                          controller:
                              TextEditingController(text: initialSelection),
                          dropdownMenuEntries: const [
                            DropdownMenuEntry(
                                leadingIcon: taskComplete,
                                label: 'المهمة اكتملت',
                                value: 'المهمة اكتملت'),
                            DropdownMenuEntry(
                                leadingIcon: taskPending,
                                label: 'لم يتم البدء بالمهمة',
                                value: 'لم يتم البدء بالمهمة'),
                            DropdownMenuEntry(
                                leadingIcon: taskOngoing,
                                label: 'المهمة قيد التنفيذ',
                                value: ' المهمة قيد التنفيذ'),
                          ],
                        )),
                    const SizedBox(
                      height: 5,
                    ),
                    TaskInfo(
                      title: 'الوصف',
                      text: state.tasks[index].content,
                    )
                  ],
                ),
              ],
            ),
          );
        },
      ),
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
      title: Text(title, style: const TextStyle(color: Colors.black)),
      subtitle: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: black)),
          child: Text(text,
              style: const TextStyle(fontSize: 15, color: Colors.black)),
        ),
      ),
    );
  }
}
