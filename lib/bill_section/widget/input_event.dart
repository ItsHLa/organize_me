import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

import '../../input_text.dart';

class InputEvent extends StatefulWidget {
  const InputEvent({super.key});

  @override
  State<InputEvent> createState() => _InputEventState();
}

class _InputEventState extends State<InputEvent> {

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  late String taskName ;

  void _selectDate(){
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      onConfirm: (date) {
        setState(() {
          selectedDate = date;
        });
      },
        locale: LocaleType.ar,
      currentTime: DateTime.now()
    );
  }

  void _selectTime(){
    DatePicker.showTimePicker(
        context,
        locale: LocaleType.ar,
        showTitleActions: true,
        onConfirm: (time) {
          setState(() {
            selectedTime = time as TimeOfDay;
          });
        },
        currentTime: DateTime.now()
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:  Container(
        margin: EdgeInsets.all(8),
        child:  Column(
          children: [
            InputText(
              hint: 'اسم المهمة',
              save: (value){
                setState(() {
                  taskName = value!;
                });
              },
            ),
            Row(
              mainAxisAlignment:MainAxisAlignment.spaceEvenly ,
              children: [
              ElevatedButton(
                  onPressed:_selectDate,
                  child: const Text('تحديد اليوم ')),
              ElevatedButton(
                  onPressed:_selectTime,
                  child: const Text(' تحديد الوقت ')),
            ],),

            ElevatedButton.icon(
                onPressed: (){
                  final event = CalendarEventData(
                    title: taskName, date: selectedDate ,
                  );
                  CalendarControllerProvider.of(context).controller.add(event);
                },
                label: Text('اضافة المهمة')
                , icon: Icon(Icons.add))

          ],
        ),
      ),

    );
  }
}
