import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/my_button.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/medicien_section/cubit/medicien_cubit.dart';

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
      padding: EdgeInsets.only(
          top: 8,
          left: 8,
          right: 8,
          bottom: MediaQuery.of(context).viewInsets.bottom),
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
              MyButton(
                  onPressed: () {
                    BlocProvider.of<MedicienCubit>(context).addMed();
                  },
                  icon: Icons.add_circle_outline,
                  label: 'اضافة الدواء'),
              const SizedBox(
                height: 15,
              )
            ],
          ),
        ),
      ),
    );
  }
}
