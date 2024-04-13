import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/medicien_section/cubit/medicien_cubit.dart';

import 'input_medicien.dart';

class AddMed extends StatelessWidget {
  const AddMed({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<MedicienCubit, MedicienState>(
      listener: (context, state) {
        if (state is AddMedSuccses) {
          Navigator.of(context).pop();
        }
      },
      child: const InputMedicien(),
    );
  }
}
