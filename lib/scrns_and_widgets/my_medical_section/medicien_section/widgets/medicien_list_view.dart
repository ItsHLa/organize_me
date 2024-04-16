import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/my_list_view.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/medicien_section/cubit/medicien_cubit.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/medicien_section/edit_medicien_screen.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/medicien_section/models/med.dart';

import 'medicien_item.dart';

class MedsListView extends StatelessWidget {
  const MedsListView({super.key, required this.meds});

  final List<Med> meds;

  @override
  Widget build(BuildContext context) {
    return MyListView(
      dataList: meds,
      itemBuilder: (context, index) {
        return MedItem(
          med: meds[index],
          onPressedEdit: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (newcontext) => BlocProvider.value(
                value: BlocProvider.of<MedicienCubit>(context),
                child: EditMedsScreen(
                  medId: meds[index].id,
                ),
              ),
            );
          },
          onPressedDelete: () {
            BlocProvider.of<MedicienCubit>(context).deleteMed(meds[index].id);
          },
        );
      },
      itemCount: meds.length,
    );
  }
}
