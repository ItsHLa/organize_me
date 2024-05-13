import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../services/functionality.dart';
import '../../add_data_page.dart';
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
          labelButton: 'اضافة الدواء',
          labels: const [
            'اسم الدواء',
            'عدد الساعات بين الجرعات',
            'موعد اخذ الدواء'
          ],
          save: [
            (value) {
              setState(
                () {
                  medicienName = value!;
                },
              );
            },
            (value) {
              setState(
                () {
                  interval = int.parse(value!);
                },
              );
            },
            null
          ],
          readOnly: const [false, false, true],
          onTap: [
            null,
            null,
            () async {
              time = (await showTimePicker(
                  context: context, initialTime: TimeOfDay.now()));
              setState(
                () {
                  shotTime = time != null
                      ? '${time?.hour.toString()}:${time?.minute.toString()}'
                      : '';
                },
              );
            }
          ],
          hint: const ['', '', ''],
          validator: const [
            ValidateInputData.checkIfNull,
            ValidateInputData.checkInterval,
            ValidateInputData.checkIfNull
          ],
          keyboardType: const [null, null, TextInputType.number],
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
