import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/task_section/widgets/add_edit_page_form.dart';
import 'package:organize_me/services/functionality.dart';

import 'cubit/task_cubit.dart';
import 'models/task.dart';

class EditTask extends StatefulWidget {
  const EditTask({super.key, required this.task});

  final Task task;

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  String editedTaskTitle = '';
  String editedTaskContent = '';
  TimeOfDay? editedStart;
  String editedStartTime = '';
  int editedPreAlarm = 0;
  DateTime? date;
  String dateTime = '';
  AutovalidateMode autoValidated = AutovalidateMode.disabled;
  GlobalKey<FormState> taskKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskCubit, TaskState>(
        listener: (newcontext, state) {
          if (state is AddTaskSuccess) {
            Navigator.of(newcontext).pop();
          }
        },
        child: Form(
          key: taskKey,
          child: TaskDataPageForm(
            datValidator: ValidateInputData.checkEditedDateTime,
            startTimeValidator: ValidateInputData.checkEditedStartTime,
            preAlarmValidator: (String? value) {
              if (value?.isEmpty ?? true) {
                return 'هذا الحقل لا يمكن ان يكون فارغ';
              }
              TimeOfDay timeNow = TimeOfDay.now();
              DateTime fullDateNow = DateTime.now();
              DateTime dateNow = DateTime(
                fullDateNow.year,
                fullDateNow.month,
                fullDateNow.day,
              );
              int diffInMinutes = 0;
              if (editedStart != null) {
                diffInMinutes = ((editedStart!.hour - timeNow.hour) * 60) +
                    (editedStart!.minute - timeNow.minute);
              }
              if (editedPreAlarm.isNegative) {
                return 'هذا الحقل لا يمكن أن يحوي أعداد سالبة';
              } else if ((value?.length ?? 0) > 10) {
                return 'هذا الحقل لا يمكن أن يكون أكبر من 10 أرقام';
              } else if ((date?.isAtSameMomentAs(dateNow) ?? false) &&
                  editedPreAlarm >= diffInMinutes) {
                return 'هذا الحقل يجب أن يكون أصغر من فرق الوقت بين الآن ووقت البدء';
              } else {
                return null;
              }
            },
            saveDate: () async {
              date = (await showDatePicker(
                context: context,
                firstDate: DateTime(2024),
                lastDate: DateTime(3000),
              ));
              setState(() {
                dateTime = date != null
                    ? '${date!.day}/${date!.month}/${date!.year}'
                    : '';
              });
            },
            date: TextEditingController(text: dateTime),
            saveTitle: (value) {
              editedTaskTitle = value ?? widget.task.title;
            },
            saveContent: (value) {
              editedTaskContent = value ?? widget.task.content;
            },
            saveStartTime: () async {
              editedStart = (await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              ));
              setState(() {
                editedStartTime = editedStart != null
                    ? '${editedStart!.hour}:${editedStart!.minute}'
                    : '';
              });
            },
            savePreAlarm: (value) {
              editedPreAlarm = int.parse(value!.isNotEmpty ? value : '0');
            },
            start: TextEditingController(text: editedStartTime),
            onPressed: () {
              taskKey.currentState?.save();
              BlocProvider.of<TaskCubit>(context).editTask(
                preAlarm: editedPreAlarm,
                id: widget.task.id,
                title: editedTaskTitle,
                content: editedTaskContent,
                startDate: date,
                startTime: editedStart,
              );
            },
            icon: Icons.edit,
            label: 'تعديل المهمة',
          ),
        ));
  }
}
