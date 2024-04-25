import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/medicien_section/widgets/input_medicien_form.dart';

import '../../add_data_page.dart';
import '../../functionality.dart';
import 'cubit/medicien_cubit.dart';

class AddMedsScreen extends StatefulWidget {
  const AddMedsScreen({super.key});

  @override
  State<AddMedsScreen> createState() => _AddMedsScreenState();
}

class _AddMedsScreenState extends State<AddMedsScreen> {
  String medicienName = '';
  int interval = 0;
  String shotTime = '';
  TimeOfDay? time;
  GlobalKey<FormState> medKey = GlobalKey();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return BlocListener<MedicineCubit, MedicineState>(
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
          child: MedsInput(
            medIntervalValidator: ValidateInputData.checkInterval,
            medNameValidator: ValidateInputData.checkIfNull,
            medShotTimeValidator: ValidateInputData.checkIfNull,
            shotTime: TextEditingController(text: shotTime),
            saveMedName: (value) {
              setState(() {
                medicienName = value!;
              });
            },
            saveMedInterval: (value) {
              setState(() {
                interval = int.parse(value!);
              });
            },
            saveMedShotTime: () async {
              time = await showTimePicker(
                  context: context, initialTime: TimeOfDay.now());
              setState(() {
                shotTime =
                '${time?.hour.toString()}:${time?.minute.toString()}';
              });
            },
          ),
          onPressed: () {
            if (ValidateInputData.validateField(medKey)) {
              medKey.currentState?.save();
              BlocProvider.of<MedicineCubit>(context).addMed(
                medicienName,
                time!,
                interval,
              );
              debugPrint('Adding Medicien');
            } else {
              autoValidate = AutovalidateMode.always;
            }
          },
        ),
      ),
    );
  }
}
