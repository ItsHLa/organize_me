import 'package:flutter/material.dart';
import 'package:date_time_picker_plus/date_time_picker_plus.dart';


class MyDatePicker extends StatelessWidget {
  const MyDatePicker({super.key, required this.title, required this.type, this.initialValue, this.onChanged,  });
  final DateTimePickerType type;
  final String? initialValue;
  final String title ;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return DateTimePicker(
      type: type ,
      initialValue: initialValue,
      firstDate: DateTime(2024),
      lastDate: DateTime(3000),
      dateHintText: title,
      timeHintText: title,
      onChanged: onChanged,
      decoration: InputDecoration(
      hintText: widget.hint,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.black12),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.black12),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.black12),
      ),
    ),
    );
  }
}
