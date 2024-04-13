import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/medicien_section/cubit/medicien_cubit.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/medicien_section/widgets/input_medicien.dart';

import '../../floating_action_button.dart';
import 'meds_grid.dart';

class MedsPage extends StatelessWidget {
  const MedsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MedicienCubit>(
      create: (context) => MedicienCubit(),
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: MyFab(
          icon: Icons.medication,
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (newcontext) => BlocProvider.value(
                value: BlocProvider.of(context),
                child: const InputMedicien(),
              ),
            );
          },
        ),
        body: const Column(
          children: [MedsGrid()],
        ),
      ),
    );
  }
}
