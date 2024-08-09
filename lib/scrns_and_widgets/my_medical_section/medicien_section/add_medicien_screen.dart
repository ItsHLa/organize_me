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
  TimeOfDay? time;
  TextEditingController shotTime = TextEditingController();
  TextEditingController medicienName = TextEditingController();
  TextEditingController interval = TextEditingController();
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
          controllers: [medicienName, interval, shotTime],
          icon: Icons.add,
          labelButton: 'اضافة الدواء',
          labels: const [
            'اسم الدواء',
            'عدد الساعات بين الجرعات',
            'موعد أخذ الدواء'
          ],
          save: [
            (value) {
              setState(
                () {
                  medicienName.text = value!;
                },
              );
            },
            (value) {
              setState(
                () {
                  interval.text = value!;
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
              time = await showTime(context);
              setState(
                () {
                  shotTime.text = time != null
                      ? '${time?.hour.toString()}:${time?.minute.toString()}'
                      : '';
                },
              );
            }
          ],
          validator: const [
            ValidateInputData.checkIfNull,
            ValidateInputData.checkInterval,
            ValidateInputData.checkIfNull
          ],
          keyboardType: const [null, TextInputType.number, null],
          onPressed: () {
            if (ValidateInputData.validateField(medKey)) {
              medKey.currentState?.save();
              BlocProvider.of<MedicineCubit>(context).addMed(
                medicienName.text,
                time!,
                int.parse(interval.text),
              );
            } else {
              autoValidate = AutovalidateMode.always;
            }
          },
        ),
      ),
    );
  }
}
