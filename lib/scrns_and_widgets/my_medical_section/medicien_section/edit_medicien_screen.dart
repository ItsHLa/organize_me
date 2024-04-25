import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/medicien_section/widgets/input_medicien_form.dart';

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
  String editedMedName = '';
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
          icon: Icons.add,
          label: 'تعديل الدواء',
          child: MedsInput(
            medIntervalValidator: (value) {
              if (value?.isEmpty ?? true) {
                return 'هذا الحقل لا يمكن ان يكون فارغ';
              }

              int interval = int.parse(value!);
              if (interval.isNegative) {
                return 'هذا الحقل لا يمكن ان يكون يحوي اعداد سالبة';
              } else {
                return null;
              }
            },
            shotTime: TextEditingController(text: editedShotTime),
            saveMedName: (value) {
              setState(() {
                editedMedName = value ?? widget.med.name;
              });
            },
            saveMedInterval: (value) {
              setState(() {
                editedMedInterval = int.parse(
                    value!.isNotEmpty ? value : widget.med.interval.toString());
              });
            },
            saveMedShotTime: () async {
              time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              setState(() {
                editedShotTime =
                '${time?.hour.toString()}:${time?.minute.toString()}';
              });
            },
          ),
          onPressed: () {
            medKey.currentState?.save();
            BlocProvider.of<MedicineCubit>(context).editMed(
                id: widget.med.id,
                editedTimeOfShot: time!,
                editedInterval: editedMedInterval,
                editedName: editedMedName);
            debugPrint('Editing Medicine');
          },
        ),
      ),
    );
  }
}
