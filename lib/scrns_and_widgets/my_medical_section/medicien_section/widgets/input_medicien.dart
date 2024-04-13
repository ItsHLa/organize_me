import 'package:flutter/material.dart';
import 'package:organize_me/scrns_and_widgets/my_button.dart';

import '../../../date_time_picker.dart';
import '../../../input_text.dart';

class InputMedicien extends StatefulWidget {
  const InputMedicien({super.key});

  @override
  State<InputMedicien> createState() => _InputMedicienState();
}

class _InputMedicienState extends State<InputMedicien> {
  String? medicienName;
  String? numberOfDoses;
  TimeOfDay? timeOfDose = TimeOfDay.now();
  TimeOfDay? reminder = TimeOfDay.now();
  GlobalKey<FormState> medsKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              InputText(
                hint: 'اسم الدواء',
                save: (value) {
                  setState(() {
                    medicienName = value;
                  });
                },
              ),
              const SizedBox(
                height: 6,
              ),
              InputText(
                hint: 'عدد جرعات',
                keyboardType: TextInputType.number,
                save: (value) async {
                  timeOfDose = await showTimePicker(
                      context: context, initialTime: TimeOfDay.now());
                },
              ),
              const SizedBox(
                height: 6,
              ),
              MyDatePicker(
                  icon: Icons.access_time_outlined,
                  labelText: 'موعد اخذ الدواء',
                  onTap: () {},
                  controller: TextEditingController(
                      text:
                          '${timeOfDose?.hour.toString()} : ${timeOfDose?.minute.toString()}')),
              const SizedBox(
                height: 6,
              ),
              MyDatePicker(
                  icon: Icons.access_time_outlined,
                  controller: TextEditingController(
                      text:
                          '${reminder?.hour.toString()} : ${reminder?.minute.toString()}'),
                  labelText: 'تذكير قبل',
                  onTap: () async {
                    reminder = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                  }),
              const SizedBox(
                height: 6,
              ),
              MyButton(
                  onPressed: () {
                    print('mssssg');
                  },
                  icon: Icons.add_circle_outline,
                  label: 'اضافة الدواء')
            ],
          ),
        ),
      ),
    );
  }
}
