import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/services/functionality.dart';

import '../../add_data_page.dart';
import 'cubit/medicien_cubit.dart';
import 'models/med.dart';

class EditMedsScreen extends StatefulWidget {
  const EditMedsScreen({super.key, required this.med});

  final Med med;

  @override
  State<EditMedsScreen> createState() => _EditMedsScreenState();
}

class _EditMedsScreenState extends State<EditMedsScreen> {
  String? editedMedName;

  int editedMedInterval = 0;

  String editedShotTime = '';
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
        key: medKey,
        child: InputDataPage(
          labels: const [
            'اسم الدواء',
            'عدد الساعات بين الجرعات',
            'موعد اخذ الدواء'
          ],
          save: [
            (value) {
              setState(
                () {
                  editedMedName = (value!.isEmpty ? widget.med.name : value);
                },
              );
            },
            (value) {
              setState(
                () {
                  editedMedInterval = int.parse(value!.isNotEmpty
                      ? value
                      : widget.med.interval.toString());
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
                  editedShotTime =
                      '${time?.hour.toString()}:${time?.minute.toString()}';
                },
              );
            }
          ],
          hint: const ['', '', ''],
          validator: const [
            ValidateInputData.checkIfNull,
            ValidateInputData.checkEditedInterval,
            ValidateInputData.checkIfNull
          ],
          keyboardType: const [null, null, TextInputType.number],
          icon: Icons.add,
          labelButton: 'تعديل الدواء',
          onPressed: () {
            medKey.currentState?.save();
            BlocProvider.of<MedicineCubit>(context).editMed(
              id: widget.med.id,
              editedTimeOfShot:
                  time ?? convertStringToTimeDay(widget.med.shotTime),
              editedInterval: editedMedInterval,
              editedName: editedMedName!,
            );
            debugPrint('Editing Medicine');
          },
        ),
      ),
    );
  }
}
