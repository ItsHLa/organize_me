import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:organize_me/scrns_and_widgets/scheduling_dates_section/widgets/month_view.dart';

import 'add_date_scrn.dart';

class CalenderView extends StatefulWidget {
  const CalenderView({super.key});

  @override
  State<CalenderView> createState() => _CalenderViewState();
}

class _CalenderViewState extends State<CalenderView> {
  @override
  Widget build(BuildContext context) {
    return CalendarControllerProvider(
      controller: EventController(),
      child: Scaffold(
<<<<<<< HEAD:lib/scrns_and_widgets/bill_section/scrns/calender_view.dart
        floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
        floatingActionButton:  FloatingActionButton.small(
          onPressed: ()  {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddTaskScrn(),));
=======
        appBar: AppBar(
          title: const Text('مواعيدي'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => const AddDateScrn(),
            );
>>>>>>> 328cb563f6df3866d8bc62b839b1d78f56ce7e7f:lib/scrns_and_widgets/scheduling_dates_section/calender_view.dart
          },
          shape: const StadiumBorder(),
          child: const Icon(Icons.add),
        ),
        body: const MonthCalender(),
      ),
    );
  }
}
