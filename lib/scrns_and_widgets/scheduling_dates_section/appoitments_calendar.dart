import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/scheduling_dates_section/add_appoitments_scrn.dart';
import 'package:organize_me/scrns_and_widgets/scheduling_dates_section/cubit/appoitment_cubit.dart';
import 'package:organize_me/scrns_and_widgets/scheduling_dates_section/widgets/appoitment_listview.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class MonthCalendar extends StatelessWidget {
  const MonthCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.small(
          shape: const StadiumBorder(),
          child: const Icon(Icons.add_circle_outline_outlined),
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
      body: BlocBuilder<AppoitmentCubit, AppoitmentState>(
        builder: (context, state) {
          return SfCalendar(
            view: CalendarView.month,
            showNavigationArrow: true,
            dataSource: state.appointmentDataSource,
            monthViewSettings: const MonthViewSettings(
              appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
            ),
            onTap: (calendarTapDetails) {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    child: Column(
                      children: [Expanded(child: AppoitmentListView())],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
