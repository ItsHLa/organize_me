import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  // String? taskContent;

  TimeOfDay? start;
  DateTime? date;

  //String dateTime = '';

  // String startTime = '';
  // int? preAlarm;

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
                          '${date!.day}/${date!.month}/${date!.year}';
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
            onPressed: () {
              var electric =
                  """تم دفع مبلغ 3920 ل.س لصالح المؤسسة العامة لنقل وتوزيع الكهرباء متضمناً 0 ل.س عمولة الدفع للفاتورة رقم 69899292 بتاريخ 08/05/2024 21:09
المحافظة: اللاذقية
رقم الفوترة: 254871
رقم الاشتراك: 157972
رقم العملية: s600068373161""";

//               var water = '''''';
//               var telecom =
//                   '''تم دفع مبلغ 5100 ل.س لصالح السورية للاتصالات متضمناً 0 ل.س عمولة الدفع للفاتورة رقم 2028066512 بتاريخ 01/05/2024 18:11
// رقم الهاتف الثابت/ البريد الإلكتروني: taghreed.h@tarassul.sy
// رقم العملية: s600075648235''';
              compareBillTest(body: electric);
              if (ValidateInputData.validateField(taskKey)) {
                taskKey.currentState!.save();
                BlocProvider.of<TaskCubit>(context).addTask(
                  content: taskContent.text,
                  title: taskTitle.text,
                  startDate: date!,
                  preAlarm: int.parse(preAlarm.text),
                  startTime: start!,
                );
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

void compareBillTest({required String body}) {
  if (waterRegex.hasMatch(body)) {
    Match match = waterRegex.firstMatch(body)!;
    WaterBill.addBill(match: match, provider: 'address');
  } else if (telecomRegex.hasMatch(body)) {
    Match match = telecomRegex.firstMatch(body)!;
    TelecomBill.addBill(match: match, provider: 'address');
  } else if (electricRegex.hasMatch(body)) {
    Match match = electricRegex.firstMatch(body)!;
    ElectricBill.addBill(match: match, provider: 'address');
  }
}
