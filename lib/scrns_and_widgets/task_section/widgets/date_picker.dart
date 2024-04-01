import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';

class MyDatePicker extends StatelessWidget {
  const MyDatePicker({
    super.key, required this.labelText, this.onChanged,});

  final String labelText;
  final void Function(DateTime?)? onChanged ;
  @override
  Widget build(BuildContext context) {
    return
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 9),
        height: 70,
        child: DateTimeFormField(
           /* decoration: InputDecoration(
              labelText: labelText,
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
            ),*/
          firstDate: DateTime.now().add(const Duration(days: 10)),
          lastDate: DateTime.now().add(const Duration(days: 40)),
          initialPickerDateTime: DateTime.now().add(const Duration(days: 20)),
          onChanged: onChanged
        ),
      );
  }
}
