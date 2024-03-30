import 'package:flutter/material.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class MyDatePicker extends StatefulWidget {
  const MyDatePicker({super.key});

  @override
  State<MyDatePicker> createState() => _MyDatePickerState();
}

class _MyDatePickerState extends State<MyDatePicker> {

  List<DateTime>? dates;

  void showDatePicker( List<DateTime>? dates ) async {
    dates = await showOmniDateTimeRangePicker(
    context: context,
    startInitialDate: DateTime.now(),
    endInitialDate: DateTime.now(),
    is24HourMode: false,
    isShowSeconds: false,
    barrierDismissible: false,
    selectableDayPredicate: (dateTime) {
      if (dateTime == DateTime.now() ){
        return false;
      } else {
        return true;
      }
    },
      minutesInterval: 1,
      secondsInterval: 1,

    );
  }

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap:  () {
        showDatePicker(dates);

    },
        child: Container(
          margin: const EdgeInsets.all(8),
          child :  Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text('Start : '),
                  Text('${ dates?[0].day} / ${dates?[0].month  } / ${dates?[0].year }  '),
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text('End : '),
                  Text('${ dates?[1].day} / ${dates?[1].month  } / ${dates?[1].year }  '),
                ],
              )
            ],
          )
        ));
  }
}
