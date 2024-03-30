import 'package:flutter/material.dart';
import 'package:date_time_picker_plus/date_time_picker_plus.dart';

class MyDatePicker extends StatefulWidget {
  const MyDatePicker({super.key, required this.type , this.initialTime, required this.onSave, this.initialDate, this.initialValue});
  final DateTimePickerType type ;
  final TimeOfDay? initialTime;
  final  DateTime? initialDate;
  final String? initialValue;
  final void Function(String?)? onSave ;

  @override
  State<MyDatePicker> createState() => _MyDatePickerState();
}

class _MyDatePickerState extends State<MyDatePicker> {
  @override
  Widget build(BuildContext context) {
    return DateTimePicker(
      type: widget.type,
      initialValue: widget.initialValue,
      initialTime: widget.initialTime,
      initialDate: widget.initialDate ,
      firstDate: DateTime(2023),
      lastDate: DateTime(4000),
      timeLabelText: 'time',
      validator: (val) {
        if(val?.isEmpty ?? true){
          return 'لا يمكن الحقل ان يكون فارغ';
        }
      },
      onSaved: widget.onSave,
    );
  }
}
