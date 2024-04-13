import 'package:flutter/material.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/medicien_section/widgets/input_medicien.dart';

import '../../floating_action_button.dart';
import 'meds_grid.dart';

class MedsPage extends StatelessWidget {
  const MedsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: MyFab(
        icon: Icons.medication,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => const InputMedicien(),
          );
        },
      ),
      body: const Column(
        children: [MedsGrid()],
      ),
    );
  }
}
