import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/constants.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/medicien_section/cubit/medicien_cubit.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/medicien_section/widgets/medicien_list_view.dart';

import '../../no_content.dart';

class MedsGrid extends StatefulWidget {
  const MedsGrid({super.key});

  @override
  State<MedsGrid> createState() => _MedsGridState();
}

class _MedsGridState extends State<MedsGrid> {
  @override
  void initState() {
    BlocProvider.of<MedicineCubit>(context).loadMedsData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MedicineCubit, MedicineState>(
      builder: (context, state) {
        if (state is LoadMeds) {
          return Center(
            child: CircularProgressIndicator(
              color: appColorTheme,
            ),
          );
        } else if (state.meds.isNotEmpty &&
            (state is MedsLoaded ||
                state is AddMedSuccses ||
                state is DeleteMedsSuccses)) {
          return MedsListView(
            meds: state.meds,
          );
        } else {
          return const NoContent(
            text: 'لا يوجد أدوية بعد',
          );
        }
      },
    );
  }
}
