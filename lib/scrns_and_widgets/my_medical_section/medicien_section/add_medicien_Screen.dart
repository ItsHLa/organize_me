import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/input_text.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/medicien_section/widgets/input_medicien_form.dart';

import '../../add_data_page.dart';
import 'cubit/medicien_cubit.dart';

class AddMedsScreen extends StatefulWidget {
  const AddMedsScreen({super.key});

  @override
  State<AddMedsScreen> createState() => _AddMedsScreenState();
}

class _AddMedsScreenState extends State<AddMedsScreen> {
  String medicienName = '';
  String numberOfDoses = '';
  String timeOfDose = '';
  GlobalKey<FormState> medKey = GlobalKey();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return BlocListener<MedicienCubit, MedicienState>(
      listener: (context, state) {
        if (state is AddMedSuccses) {
          Navigator.of(context).pop();
        }
      },
      child: Form(
        autovalidateMode: autoValidate,
        key: medKey,
        child: InputDataPage(
          icon: Icons.add,
          label: 'اضافة الدواء',
          onPressed: () {
            if (InputText.validateField(medKey)) {
              medKey.currentState?.validate();
              BlocProvider.of<MedicienCubit>(context).addMed();
              print('Adding Medicien');
            } else {
              autoValidate = AutovalidateMode.always;
            }
          },
          child: MedsInput(
            timeOfDoses: TextEditingController(text: timeOfDose),
            saveMedName: (value) {
              setState(() {
                medicienName = value!;
              });
            },
            saveMedDoses: (value) {
              setState(() {
                numberOfDoses = value!;
              });
            },
            saveMedsTime: () async {
              TimeOfDay? time = await showTimePicker(
                  context: context, initialTime: TimeOfDay.now());
              setState(() {
                timeOfDose =
                    '${time?.hour.toString()} : ${time?.minute.toString()}';
              });
            },
          ),
        ),
      ),
    );
  }
}
