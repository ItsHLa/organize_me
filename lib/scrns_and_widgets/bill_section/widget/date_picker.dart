import 'package:flutter/material.dart';
import 'package:date_time_picker_plus/date_time_picker_plus.dart';


class MyDatePicker extends StatefulWidget {
  const MyDatePicker({super.key, required this.title, this.onTap,  });
  final String title ;
  final void Function()? onTap;

  @override
  State<MyDatePicker> createState() => _MyDatePickerState();
}

class _MyDatePickerState extends State<MyDatePicker> {
  String ? date ;
  @override
  Widget build(BuildContext context) {
    return DateTimePicker(
      initialValue: '',
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      dateLabelText: 'Date',
      onChanged: (val) => print(val),
      validator: (val) {
        print(val);
        return null;
      },
      onSaved: (val) => print(val),
    );;
  }
}
