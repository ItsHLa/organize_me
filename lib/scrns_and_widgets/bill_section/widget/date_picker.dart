import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';


class MyDatePicker extends StatefulWidget {
  const MyDatePicker({
    super.key,});
  static void selectDate ( BuildContext context){
    DatePicker.showDateTimePicker(context,
        showTitleActions: true,
        onChanged: (date) {
          print('change ${date.day}');
          print('change ${date.hour}');
        },
        onConfirm: (date) {
          print('confirm $date');
        },
        currentTime: DateTime.now(),
        locale: LocaleType.ar);
  }



  @override
  State<MyDatePicker> createState() => _MyDatePickerState();
}



class _MyDatePickerState extends State<MyDatePicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const Row(
       children: [
         Text('24/10/2014'),
         Text('7:00')
       ],

      )
      );
  }
}
