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
  String? DateName;

  void myDatePicker(TextEditingController controller) async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(3000),
    );
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    setState(() {
      controller.text =
          ' ${date!.day} / ${date!.month}/ ${date!.year} - ${time!.hour} : ${time!.minute}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
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
                    DateName = value!;
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
