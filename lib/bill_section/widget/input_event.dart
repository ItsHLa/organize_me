import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

import '../../input_text.dart';

class InputEvent extends StatefulWidget {
  const InputEvent({super.key});

  @override
  State<InputEvent> createState() => _InputEventState();
}

class _InputEventState extends State<InputEvent> {

  AutovalidateMode validate = AutovalidateMode.disabled;
  GlobalKey<FormState> eventFormKey = GlobalKey<FormState>();



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
    return Padding(
      padding:  EdgeInsets.only(
          left: 8.0 ,
          right: 8 ,
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(height: 15),
            Form(
              key: eventFormKey,
              autovalidateMode: validate,
              child: InputText(
                hint: 'اسم المهمة',
                save: (value){
                  setState(() {
                    taskName = value!;
                  });
                },
              ),
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
                  if(eventFormKey.currentState!.validate()){
                    eventFormKey.currentState!.save();
                    final event = CalendarEventData(
                      title: taskName, date: selectedDate ,
                    );
                    CalendarControllerProvider.of(context).controller.add(event);
                  }else{
                    validate = AutovalidateMode.always;
                  }

                },
                label:const  Text('اضافة المهمة')
                , icon: const Icon(Icons.add)),
            const SizedBox(height: 15),

          ],
        ),

      ),
    );
  }
}
