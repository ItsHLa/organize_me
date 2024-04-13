import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/medicien_section/cubit/medicien_cubit.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/medicien_section/widgets/medicien_list_view.dart';

class MedsGrid extends StatelessWidget {
  const MedsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    //BlocProvider.of<MedicienCubit>(context).loadMedsData();
    return BlocBuilder<MedicienCubit, MedicienState>(
      builder: (context, state) {
        if (state is LoadMeds) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is MedsLoaded ||
            state is AddMedSuccses ||
            state is DeleteMedsSuccses && state.Meds.isNotEmpty) {
          return const Expanded(
              child: MedsListView(
            Meds: [],
          ));
        } else {
          return const Center(
            child: Text('لا يوجد ادوية بعد'),
          );
        }
      },
    );
  }
}
