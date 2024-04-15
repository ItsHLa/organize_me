import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/medicien_section/cubit/medicien_cubit.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/medicien_section/widgets/medicien_list_view.dart';

class MedsGrid extends StatelessWidget {
  const MedsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<MedicienCubit>(context).loadMedsData();
    return BlocBuilder<MedicienCubit, MedicienState>(
      builder: (context, state) {
        if (state is LoadMeds) {
          return const Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state.meds.isNotEmpty &&
            (state is MedsLoaded ||
                state is AddMedSuccses ||
                state is DeleteMedsSuccses)) {
          return Expanded(
            child: MedsListView(
              meds: state.meds,
            ),
          );
        } else {
          return const Expanded(
            child: Center(
              child: Text(
                'لا يوجد أدوية بعد',
                style: TextStyle(fontSize: 20),
              ),
            ),
          );
        }
      },
    );
  }
}
