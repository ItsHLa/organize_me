import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/medicien_section/widgets/input_medicien_form.dart';

import '../../add_data_page.dart';
import 'cubit/medicien_cubit.dart';

class EditMedsScreen extends StatefulWidget {
  const EditMedsScreen({super.key, required this.medId});

  final int medId;

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
          label: 'تعديل الدواء',
          child: MedsInput(
            shotTime: TextEditingController(text: editedShotTime),
            saveMedName: (value) {
              setState(() {
                editedMedName = value ?? '';
              });
            },
            saveMedInterval: (value) {
              setState(() {
                editedMedInterval = int.parse(value!.isNotEmpty ? value : '0');
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
            BlocProvider.of<MedicienCubit>(context).editMed(
              medId: widget.medId,
              editedInterval: editedMedInterval,
              editedName: editedMedName,
              editedShotTime: time,
            );
            debugPrint('Editing Medicien');
          },
        ),
      ),
    );
  }
}
