import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/scheduling_dates_section/add_appoitments_scrn.dart';
import 'package:organize_me/scrns_and_widgets/scheduling_dates_section/cubit/appoitment_cubit.dart';
import 'package:organize_me/scrns_and_widgets/scheduling_dates_section/models/appointmentDataSource.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class MonthCalendar extends StatelessWidget {
  const MonthCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppoitmentCubit, AppoitmentState>(
      listener: (context, state) {},
      child: Scaffold(
        floatingActionButton: BlocProvider<AppoitmentCubit>.value(
          value: BlocProvider.of(context),
          child: FloatingActionButton.small(
              shape: const StadiumBorder(),
              child: const Icon(Icons.add_circle_outline_outlined),
              onPressed: () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) {
                      return const AddDateScrn();
                    });
              }),
        ),
        body: SfCalendar(
          view: CalendarView.month,
          showNavigationArrow: true,
          dataSource: AppointmentDataSource(
              BlocProvider.of<AppoitmentCubit>(context).appointments),
          monthViewSettings: const MonthViewSettings(
            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
          ),
        ),
      ),
    );
  }
}
