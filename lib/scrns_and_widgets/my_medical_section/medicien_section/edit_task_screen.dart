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
  String editedMedName = '';
  String editedMedInterval = '';
  String editedShotTime = '';
  GlobalKey<FormState> medKey = GlobalKey();

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
        child: MedsInput(
          shotTime: TextEditingController(text: editedShotTime),
          saveMedName: (value) {
            setState(() {
              editedMedName = value!;
            });
          },
          saveMedInterval: (value) {
            setState(() {
              editedMedInterval = value!;
            });
          },
          saveMedShotTime: () async {
            TimeOfDay? time = await showTimePicker(
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
          BlocProvider.of<MedicienCubit>(context).editMed();
          debugPrint('Editing Medicien');
        },
      ),
    );
  }
}
