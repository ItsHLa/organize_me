import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/medicien_section/widgets/input_medicien_form.dart';

import '../../add_data_page.dart';
import 'cubit/medicien_cubit.dart';

class EditMedsScreen extends StatefulWidget {
  const EditMedsScreen({
    super.key,
    //  required this.med
  });

  // final Medicien med;

  @override
  State<EditMedsScreen> createState() => _EditMedsScreenState();
}

class _EditMedsScreenState extends State<EditMedsScreen> {
  String editedMedicienName = '';
  String editedNumberOfDoses = '';
  String editedTimeOfDose = '';

  @override
  Widget build(BuildContext context) {
    return BlocListener<MedicienCubit, MedicienState>(
      listener: (context, state) {
        if (state is AddMedSuccses) {
          Navigator.of(context).pop();
        }
      },
      child: InputDataPage(
        icon: Icons.add,
        label: 'تعديل الدواء',
        onPressed: () {
          BlocProvider.of<MedicienCubit>(context).editMed();
          print('Editing Medicien');
        },
        child: MedsInput(
          timeOfDoses: TextEditingController(text: editedTimeOfDose),
          saveMedName: (value) {
            setState(() {
              editedMedicienName = value!;
            });
          },
          saveMedDoses: (value) {
            setState(() {
              editedNumberOfDoses = value!;
            });
          },
          saveMedsTime: () async {
            TimeOfDay? time = await showTimePicker(
                context: context, initialTime: TimeOfDay.now());
            setState(() {
              editedTimeOfDose =
                  '${time?.hour.toString()} : ${time?.minute.toString()}';
            });
          },
        ),
      ),
    );
  }
}
