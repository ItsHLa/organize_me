import 'package:animated_rail/animated_rail/animated_rail.dart';
import 'package:animated_rail/animated_rail/rail_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/doctors_numbers.dart';
import 'package:organize_me/scrns_and_widgets/scheduling_dates_section/appoitments_calendar.dart';
import 'package:organize_me/scrns_and_widgets/scheduling_dates_section/cubit/appoitment_cubit.dart';
import 'package:organize_me/scrns_and_widgets/task_section/task_view.dart';

import '../constants.dart';
import 'bill_section/bills_view.dart';
import 'notes_section/note_view.dart';

class MDrawe extends StatelessWidget {
  const MDrawe({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedRail(
        width: 100,
        maxWidth: 175,
        background: deepPurple,
        expand: true,
        railTileConfig: const RailTileConfig(
          iconColor: Colors.white,
          activeColor: Colors.white54,
          expandedTextStyle: TextStyle(fontSize: 15),
          collapsedTextStyle: TextStyle(fontSize: 12, color: Colors.white),
          iconPadding: EdgeInsets.symmetric(vertical: 5),
          hideCollapsedText: true,
        ),
        items: [
          RailItem(
              icon: const Icon(Icons.task_alt_outlined),
              label: "مهام",
              screen: buildScrn('مهام')),
          RailItem(
              icon: const Icon(Icons.medical_information_outlined),
              label: "مواعيد",
              screen: buildScrn('مواعيد')),
          RailItem(
              icon: const Icon(Icons.note_alt),
              label: "مفكرة",
              screen: buildScrn('مفكرة')),
          RailItem(
              icon: const Icon(Icons.payments),
              label: 'فواتير',
              screen: buildScrn('فواتير')),
          RailItem(
              icon: const Icon(Icons.medical_information_outlined),
              label: "صحة",
              screen: buildScrn('صحة')),
        ]);
  }

  buildScrn(String title) {
    switch (title) {
      case 'مواعيد':
        return BlocProvider<AppoitmentCubit>(
            create: (context) => AppoitmentCubit(),
            child: const MonthCalendar());
      case "مهام":
        return const DayCalendar();
      case "مفكرة":
        return const NoteView();
      case "فواتير":
        return const MyBills();
      case "صحة":
        return const MedsAndDocs();
    }
  }
}
