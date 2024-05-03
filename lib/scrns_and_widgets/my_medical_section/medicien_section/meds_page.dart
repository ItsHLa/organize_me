import 'package:flutter/material.dart';

import 'meds_list.dart';

class MedsPage extends StatelessWidget {
  const MedsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
/*      floatingActionButton: MyFab(
        icon: Icons.medication,
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (newcontext) => BlocProvider<MedicineCubit>.value(
              value: BlocProvider.of(context),
              child: const AddMedsScreen(),
            ),
          );
        },
      ),*/
      body: Column(
        children: [MedsGrid()],
      ),
    );
  }
}
