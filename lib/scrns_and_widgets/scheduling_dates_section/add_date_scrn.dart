import 'package:flutter/material.dart';
import 'package:organize_me/scrns_and_widgets/scheduling_dates_section/widgets/date_picker.dart';

import '../input_text.dart';

class AddDateScrn extends StatefulWidget {
  const AddDateScrn({super.key});

  @override
  State<AddDateScrn> createState() => _AddDateScrnState();
}

class _AddDateScrnState extends State<AddDateScrn> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();
  String? dateName;

  int setHour12(int hour) {
    switch (hour) {
      case 13:
        return 1;
      case 14:
        return 2;
      case 15:
        return 3;
      case 16:
        return 4;
      case 17:
        return 5;
      case 18:
        return 6;
      case 19:
        return 7;
      case 20:
        return 8;
      case 21:
        return 9;
      case 22:
        return 10;
      case 23:
        return 11;
      case 24:
        return 12;
      default:
        return hour;
    }
  }

  void myDatePicker(TextEditingController controller) async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(3000),
    );

    TimeOfDay? time = await showTimePicker(
      context: context.mounted ? context : context,
      initialTime: TimeOfDay.now(),
    );

    setState(() {
      controller.text =
          ' ${date!.day} / ${date.month} / ${date.year} - ${setHour12(time!.hour)} : ${time.minute} ';
      print(time.hour);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: 8, right: 8, bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Form(
              key: formKey,
              child: InputText(
                hint: 'اسم المهمة',
                save: (value) {
                  setState(() {
                    dateName = value!;
                  });
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            MyDatePicker(
                controller: startDate,
                labelText: 'موعد البدء',
                onTap: () {
                  myDatePicker(startDate);
                }),
            const SizedBox(
              height: 5,
            ),
            MyDatePicker(
              onTap: () {
                myDatePicker(endDate);
              },
              labelText: 'موعد الانتهاء',
              controller: endDate,
            ),
            const SizedBox(
              height: 5,
            ),
            ElevatedButton(
                onPressed: () async {
                  //  formKey.currentState!.save();
                },
                child: const Text('إضافة المهمة')),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
