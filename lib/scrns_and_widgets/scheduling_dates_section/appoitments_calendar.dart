import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/scheduling_dates_section/add_appoitments_scrn.dart';
import 'package:organize_me/scrns_and_widgets/scheduling_dates_section/cubit/appoitment_cubit.dart';
import 'package:table_calendar/table_calendar.dart';

import '../app_bar.dart';

class MonthCalendar extends StatelessWidget {
  const MonthCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.small(
            shape: const StadiumBorder(),
            child: const Icon(Icons.calendar_today_outlined),
            onPressed: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (newcontext) {
                    return BlocProvider<AppoitmentCubit>.value(
                      value: BlocProvider.of(context),
                      child: const AddDateScrn(),
                    );
                  });
            }),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const MAppBar(),
              Card(
                margin: const EdgeInsets.all(8.0),
                elevation: 5.0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  side: BorderSide(width: 2.0),
                ),
                child: BlocBuilder<AppoitmentCubit, AppoitmentState>(
                  builder: (context, state) {
                    return TableCalendar(
                      currentDay: DateTime.now(),
                      focusedDay: DateTime.now(),
                      firstDay: DateTime(2024),
                      lastDay: DateTime(3000),
                      calendarFormat: CalendarFormat.month,
                      daysOfWeekHeight: 40.0,
                      rowHeight: 60.0,
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
