import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/scheduling_dates_section/add_date_scrn.dart';
import 'package:organize_me/scrns_and_widgets/scheduling_dates_section/cubit/add_date_cubit/add_date_cubit.dart';
import 'package:organize_me/scrns_and_widgets/scheduling_dates_section/widgets/month_view.dart';

class CalenderView extends StatefulWidget {
  const CalenderView({super.key});

  @override
  State<CalenderView> createState() => _CalenderViewState();
}

class _CalenderViewState extends State<CalenderView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => BlocProvider<AddDateCubit>(
                create: (BuildContext context) => AddDateCubit(),
                child: const AddDateScrn()),
          );
        },
        shape: const StadiumBorder(),
        child: const Icon(Icons.add),
      ),
      body: const MonthCalender(),
    );
  }
}
