import 'package:flutter/material.dart';
import 'package:organize_me/scrns_and_widgets/scheduling_dates_section/widgets/appoitment_Item.dart';

class AppoitmentListView extends StatelessWidget {
  const AppoitmentListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return AppoitmentItem(index: index);
      },
    );
  }
}
