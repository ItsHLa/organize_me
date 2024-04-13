import 'package:flutter/material.dart';
import 'package:organize_me/scrns_and_widgets/my_list_view.dart';

import 'medicien_item.dart';

class MedsListView extends StatelessWidget {
  const MedsListView({super.key, required this.Meds});

  final List Meds;

  @override
  Widget build(BuildContext context) {
    return MyListView(
        dataList: Meds,
        itemBuilder: (context, index) {
          return const MedItem(
            medTitle: 'سيتامول',
            numberOfDoses: '2',
            timeOfMeds: [],
          );
        },
        itemCount: 100
        //Meds.length
        );
  }
}
