import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/task_section/cubit/task_cubit.dart';
import 'package:organize_me/services/functionality.dart';

import '../add_data_page.dart';
import 'models/task.dart';

class EditTask extends StatefulWidget {
  const EditTask({super.key, required this.task});

  final Task task;

  @override
  State<EditTask> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<EditTask> {

  TimeOfDay? editedStart;
  DateTime? date;
  String title = '';
  String selectedDate = '';
  String selectedTime = '';
  String content = '';
  TextEditingController dateTime = TextEditingController();
  TextEditingController startTime = TextEditingController();
  TextEditingController editedTaskTitle = TextEditingController();
  TextEditingController editedTaskContent = TextEditingController();
  TextEditingController editedPreAlarm = TextEditingController();

  void initState() {
    dateTime.text = widget.task.startDate;
    startTime.text = widget.task.startTime;
    editedPreAlarm.text = widget.task.preAlarm.toString();
    editedTaskContent.text = widget.task.content;
    editedTaskTitle.text = widget.task.title;
    super.initState();
  }

  AutovalidateMode autoValidated = AutovalidateMode.disabled;
  GlobalKey<FormState> taskKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      child: BlocListener<TaskCubit, TaskState>(
        listener: (newcontext, state) {
          if (state is AddTaskSuccess) {
            Navigator.of(newcontext).pop();
          }
          if (state is AddTaskFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.msg),
                duration: const Duration(minutes: 1),
              ),
            );
          }
        },
        child: Form(
          key: taskKey,
          autovalidateMode: autoValidated,
          child: InputDataPage(
            controllers: [
              editedTaskTitle,
              editedTaskContent,
              dateTime,
              startTime,
              editedPreAlarm
            ],
            labels: const [
              'اسم المهمة',
              'وصف المهمة',
              ' تاريخ المهمة',
              'وقت البدء',
              'ذكرني قبل دقائق'
            ],
            validator: [
              null,
              null,
              ValidateInputData.checkDateTime,
              (value) {
                return ValidateInputData.checkEditedStartTime(
                    value, dateTime.text);
              },
              (value) {
                return ValidateInputData.checkEditedTaskInterval(
                    value, startTime.text, dateTime.text);
              }
            ],
            onTap: [
              null,
              null,
              () async {
                date = await showDate(context);
                setState(
                  () {
                    if (date != null) {
                      dateTime.text =
                          '${date!.day}/${date!.month}/${date!.year}';
                    }
                  },
                );
              },
              () async {
                editedStart = await showTime(context);
                setState(
                  () {
                    if (editedStart != null) {
                      startTime.text =
                          '${editedStart!.hour}:${editedStart!.minute}';
                    }
                  },
                );
              },
              null
            ],
            readOnly: const [false, false, true, true, false],
            save: [
              (value) {
                editedTaskTitle.text = value ?? widget.task.title;
              },
              (value) {
                editedTaskContent.text = value ?? widget.task.content;
              },
              null,
              null,
              (value) {
                setState(
                  () {
                    editedPreAlarm.text = value!.isEmpty
                        ? widget.task.preAlarm.toString()
                        : value;
                  },
                );
              }
            ],
            keyboardType: const [null, null, null, null, TextInputType.number],
            onPressed: () {
              if (ValidateInputData.validateField(taskKey)) {
                taskKey.currentState?.save();
                BlocProvider.of<TaskCubit>(context).editTask(
                  preAlarm: int.parse(editedPreAlarm.text),
                  id: widget.task.id,
                  title: editedTaskTitle.text,
                  content: editedTaskContent.text,
                  startDate: convertStringToDateTime(dateTime.text),
                  startTime: convertStringToTimeDay(startTime.text),
                );
              } else {
                autoValidated = AutovalidateMode.always;
              }
            },
            icon: Icons.add_task_outlined,
            labelButton: 'تعديل المهمة',
          ),
        ),
      ),
    );
  }
}

/*import 'package:flutter/material.dart';
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
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      child: BlocListener<TaskCubit, TaskState>(
          listener: (newcontext, state) {
            if (state is AddTaskSuccess) {
              Navigator.of(newcontext).pop();
            }
          },
          child: Form(
            key: taskKey,
            child: TaskDataPageForm(
              datValidator: ValidateInputData.checkEditedDateTime,
             startTimeValidator: (value){
                return ValidateInputData.checkEditedStartTime(value , date!);
             },
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
                  return ' يجب أن تكون القيمة أصغر من فرق الوقت بين الآن و وقت البدء';
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
          )),
    );
  }
}
*/
