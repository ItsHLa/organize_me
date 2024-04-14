import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/my_list_view.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/medicien_section/cubit/medicien_cubit.dart';

import 'medicien_item.dart';

class MedsListView extends StatelessWidget {
  const MedsListView({super.key, required this.meds});

  final List meds;

  @override
  Widget build(BuildContext context) {
    return MyListView(
        dataList: meds,
        itemBuilder: (context, index) {
          return MedItem(
            medTitle: 'سيتامول',
            numberOfDoses: '2',
            timeOfMeds: ['7:00', '3:00', '10:00'].toString(),
            //onPressedEdit: () {
            //showModalBottomSheet(
            //isScrollControlled: true,
            //context: context,
            //builder: (newcontext) =>
            //  BlocProvider.value(
            //  value: BlocProvider.of(context),
            // child: EditMedsScreen(),
            //           ),
            // );
            // },
            onPressedDelete: () {
              BlocProvider.of<MedicienCubit>(context).deleteMed();
            },
          );
        },
        itemCount: 100
        //Meds.length
        );
  }
}
