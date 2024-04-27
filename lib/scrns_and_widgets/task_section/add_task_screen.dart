import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/task_section/cubit/task_cubit.dart';
import 'package:organize_me/scrns_and_widgets/task_section/widgets/add_edit_page_form.dart';
import 'package:organize_me/services/functionality.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  String taskTitle = '';
  String taskContent = '';

  TimeOfDay? start;
  DateTime? date;
  String dateTime = '';
  String startTime = '';
  int preAlarm = 0;
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
          child: TaskDataPageForm(
            contentValidator: ValidateInputData.checkIfNull,
            taskTitleValidator: ValidateInputData.checkIfNull,
            datValidator: ValidateInputData.checkDateTime,
            startTimeValidator: ValidateInputData.checkStartTime,
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
              int diffInMinutes = start != null
                  ? ((start!.hour - timeNow.hour) * 60) +
                      (start!.minute - timeNow.minute)
                  : 0;

              if (preAlarm.isNegative) {
                return 'هذا الحقل لا يمكن أن يحوي أعداد سالبة';
              } else if ((value?.length ?? 0) > 10) {
                return 'هذا الحقل لا يمكن أن يكون أكبر من 10 أرقام';
              } else if ((date?.isAtSameMomentAs(dateNow) ?? false) &&
                  preAlarm >= diffInMinutes) {
                return 'هذا الحقل يجب أن يكون أصغر من فرق الوقت بين الآن ووقت البدء';
              } else {
                return null;
              }
            },
            saveDate: () async {
              date = await showDatePicker(
                context: context,
                firstDate: DateTime(2024),
                lastDate: DateTime(3000),
                initialEntryMode: DatePickerEntryMode.input,
                errorFormatText: 'خطأ في الصيغة',
                errorInvalidText: 'لا يمكن ان يكون الوقت قبل الوقت الحالي',
                initialDate: DateTime.now(),
              );
              setState(
                () {
                  if (date != null) {
                    dateTime = '${date!.day}/${date!.month}/${date!.year}';
                  }
                },
              );
            },
            date: TextEditingController(text: dateTime),
            saveTitle: (value) {
              taskTitle = value ?? '';
            },
            saveContent: (value) {
              taskContent = value ?? '';
            },
            saveStartTime: () async {
              start = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
                errorInvalidText: 'لا يمكن ان يكون اليوم قبل اليوم الحالي',
              );
              setState(
                () {
                  if (start != null) {
                    startTime = '${start!.hour}:${start!.minute}';
                  }
                },
              );
            },
            savePreAlarm: (value) {
              setState(
                () {
                  preAlarm = int.parse(value!);
                },
              );
            },
            start: TextEditingController(text: startTime),
            onPressed: () {
              taskKey.currentState!.save();
              if (ValidateInputData.validateField(taskKey)) {
                BlocProvider.of<TaskCubit>(context).addTask(
                  status: '',
                  content: taskContent,
                  title: taskTitle,
                  startDate: date!,
                  preAlarm: preAlarm,
                  startTime: start!,
                );
              } else {
                autoValidated = AutovalidateMode.always;
              }
            },
            icon: Icons.add_task_outlined,
            label: 'اضافة المهمة',
          ),
        ),
      ),
    );
  }
}
