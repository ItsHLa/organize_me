import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';
import 'package:organize_me/constants.dart';
import 'package:organize_me/scrns_and_widgets/scheduling_dates_section/add_appoitments_scrn.dart';
import 'package:organize_me/scrns_and_widgets/scheduling_dates_section/cubit/appoitment_cubit.dart';

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
      body: BlocBuilder<AppoitmentCubit, AppoitmentState>(
        builder: (context, state) {
            return Calendar(
              eventColor: deepPurple,
              initialDate: DateTime.now(),
              eventsList: [
                NeatCleanCalendarEvent('meeting',
                    startTime: DateTime.now(), endTime: DateTime.now()),
              ],
              selectedTodayColor: Colors.deepPurpleAccent,
              isExpandable: true,
              isExpanded: true,
              selectedColor: deepPurple,
            );

            /*SfCalendar(
            view: CalendarView.month,
            allowAppointmentResize: true,
            allowDragAndDrop: true,
            scheduleViewSettings: ScheduleViewSettings(appointmentItemHeight: 20),
            showNavigationArrow: true,
            dataSource: state.appointmentDataSource,
            monthViewSettings: const MonthViewSettings(

              showTrailingAndLeadingDates: true,
             showAgenda: true,
              appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
            ),

                  )*/
            ;
          },
        ));
  }
}
