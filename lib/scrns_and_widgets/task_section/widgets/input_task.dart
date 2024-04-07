import 'package:flutter/material.dart';

import '../../date_time_picker.dart';
import '../../input_text.dart';

class InputTask extends StatefulWidget {
  const InputTask({super.key});

  @override
  State<InputTask> createState() => _InputTaskState();
}

class _InputTaskState extends State<InputTask> {
  GlobalKey<FormState> Taskkey = GlobalKey<FormState>();
  TextEditingController start = TextEditingController();
  TextEditingController end = TextEditingController();
  TimeOfDay? starTime;

  TimeOfDay? endTime;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          padding: EdgeInsets.only(
              right: 9,
              left: 9,
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Form(
            key: Taskkey,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                const InputText(
                  hint: 'وصف المهمة',
                  save: null,
                ),
                const SizedBox(
                  height: 5,
                ),
                MyDatePicker(
                    labelText: 'وقت البدء',
                    onTap: () async {
                      starTime = await showTimePicker(
                          context: context, initialTime: TimeOfDay.now());
                      setState(() {
                        start.text = starTime.toString();
                      });
                    },
                    controller: start),
                const SizedBox(
                  height: 5,
                ),
                MyDatePicker(
                    labelText: 'وقت الانتهاء',
                    onTap: () async {
                      endTime = await showTimePicker(
                          context: context, initialTime: TimeOfDay.now());
                      setState(() {
                        end.text = endTime.toString();
                      });
                    },
                    controller: end),
                const SizedBox(
                  height: 5,
                ),
                ElevatedButton(onPressed: null, child: Text('اضافة المهمة')),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          )),
    );
  }
}
