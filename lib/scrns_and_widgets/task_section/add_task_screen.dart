import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/models/bill.dart';
import 'package:organize_me/scrns_and_widgets/task_section/cubit/task_cubit.dart';
import 'package:organize_me/services/functionality.dart';

import '../../constants.dart';
import '../add_data_page.dart';
import '../bill_section/models/electric_bill.dart';
import '../bill_section/models/telecom_bill.dart';
import '../bill_section/models/water_bill.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  TextEditingController taskTitle = TextEditingController();
  TextEditingController taskContent = TextEditingController();
  TextEditingController dateTime = TextEditingController();
  TextEditingController startTime = TextEditingController();
  TextEditingController preAlarm = TextEditingController();

  TimeOfDay? start;
  DateTime? date;

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
              taskTitle,
              taskContent,
              dateTime,
              startTime,
              preAlarm
            ],
            labels: const [
              'اسم المهمة',
              'وصف المهمة',
              ' تاريخ المهمة',
              'وقت البدء',
              'ذكرني قبل دقائق'
            ],
            validator: [
              ValidateInputData.checkIfNull,
              ValidateInputData.checkIfNull,
              (value) {
                return ValidateInputData.checkDateTime(dateTime.text);
              },
              (value) {
                return ValidateInputData.checkStartTime(
                    startTime.text, dateTime.text);
              },
              (value) {
                return ValidateInputData.checkTaskInterval(
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
                          '${date!.year}-${date!.month}-${date!.day}';
                    }
                  },
                );
              },
              () async {
                start = await showTime(context);
                setState(
                  () {
                    if (start != null) {
                      startTime.text = '${start!.hour}:${start!.minute}';
                    }
                  },
                );
              },
              null
            ],
            readOnly: const [false, false, true, true, false],
            save: [
              (value) {
                taskTitle.text = value ?? '';
              },
              (value) {
                taskContent.text = value ?? '';
              },
              null,
              null,
              (value) {
                preAlarm.text = value ?? '0';
              }
            ],
            keyboardType: const [null, null, null, null, TextInputType.number],
            onPressed: () async {
              // to fill the database with dummy data for testing
              //await addDummyBills(dummyElectric);
              //await addDummyBills(dummyTelecom);
              //await addDummyBills(dummyWater);

              if (ValidateInputData.validateField(taskKey)) {
                taskKey.currentState!.save();
                if (context.mounted) {
                  BlocProvider.of<TaskCubit>(context).addTask(
                    content: taskContent.text,
                    title: taskTitle.text,
                    startDate: date!,
                    preAlarm: int.parse(preAlarm.text),
                    startTime: start!,
                  );
                }
              } else {
                autoValidated = AutovalidateMode.always;
              }
            },
            icon: Icons.add_task_outlined,
            labelButton: 'اضافة المهمة',
          ),
        ),
      ),
    );
  }
}

Future<void> addDummyBills(String body) async {
  if (waterRegex.hasMatch(body)) {
    Match match = waterRegex.firstMatch(body)!;
    await Bill.addBill(
      tableName: WaterBill.tableName,
      match: match,
      extractMatches: WaterBill.extractMatches,
      provider: 'address',
      tempTableName: WaterBill.tempTableName,
    );
  } else if (telecomRegex.hasMatch(body)) {
    Match match = telecomRegex.firstMatch(body)!;
    await Bill.addBill(
      tableName: TelecomBill.tableName,
      match: match,
      extractMatches: TelecomBill.extractMatches,
      provider: 'address',
      tempTableName: TelecomBill.tempTableName,
    );
  } else if (electricRegex.hasMatch(body)) {
    Match match = electricRegex.firstMatch(body)!;
    await Bill.addBill(
      tableName: ElectricBill.tableName,
      match: match,
      extractMatches: ElectricBill.extractMatches,
      provider: 'address',
      tempTableName: ElectricBill.tempTableName,
    );
  }
}
