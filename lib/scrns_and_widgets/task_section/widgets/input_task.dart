import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../date_time_picker.dart';
import '../../input_text.dart';
import '../cubit/task_cubit.dart';

class InputTask extends StatefulWidget {
  const InputTask({super.key});

  @override
  State<InputTask> createState() => _InputTaskState();
}

class _InputTaskState extends State<InputTask> {
  GlobalKey<FormState> taskKey = GlobalKey<FormState>();
  TextEditingController start = TextEditingController();
  TextEditingController end = TextEditingController();
  String? taskType;
  String? taskDescription;
  TimeOfDay? starTime;
  TimeOfDay? endTime;
  AutovalidateMode autoValidate = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
            right: 9,
            left: 9,
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Form(
          autovalidateMode: autoValidate,
          key: taskKey,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              InputText(
                hint: 'نوع المهمة',
                save: (value) {
                  setState(() {
                    taskType = value;
                  });
                },
              ),
              InputText(
                hint: 'وصف المهمة',
                save: (value) {
                  setState(() {
                    taskDescription = value;
                  });
                },
              ),
              const SizedBox(
                height: 5,
              ),
              MyDatePicker(
                labelText: 'وقت البدء',
                onTap: () async {
                  starTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  setState(
                        () {
                      start.text = starTime.toString();
                    },
                  );
                },
                controller: start,
              ),
              const SizedBox(
                height: 5,
              ),
              MyDatePicker(
                labelText: 'وقت الانتهاء',
                onTap: () async {
                  endTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  setState(
                    () {
                      end.text = endTime.toString();
                    },
                  );
                },
                controller: end,
              ),
              const SizedBox(
                height: 5,
              ),
              ElevatedButton(
                onPressed: () {
                  if (InputText.validateField(taskKey)) {
                    taskKey.currentState?.validate();
                    BlocProvider.of<TaskCubit>(context).addTask();
                  } else {
                    autoValidate = AutovalidateMode.always;
                  }
                },
                child: Text('اضافة المهمة'),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
