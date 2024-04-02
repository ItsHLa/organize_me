import 'package:flutter/material.dart';
import 'package:organize_me/scrns_and_widgets/scheduling_dates_section/widgets/date_picker.dart';

import '../input_text.dart';

class AddDateScrn extends StatefulWidget {
  const AddDateScrn({super.key});

  @override
  State<AddDateScrn> createState() => _AddDateScrnState();
}

class _AddDateScrnState extends State<AddDateScrn> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? taskName;
  String? startDate;
  String? startTime;
  String? endDate;
  String? endTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:  SingleChildScrollView(
        child: Column(
         children: [
            const Row(
             children: [
               SizedBox(width: 15,),
               Icon(Icons.add_task,size: 25,),
               SizedBox(width: 15,),
               Text('إضافة المهمة',style: TextStyle(fontSize: 20),),
             ],
           ),
           const SizedBox(height: 15,),
           Form(
             key : formKey,
              child: InputText(
                hint: 'اسم المهمة',
                save: (value) {
                  setState(() {
                    taskName = value!;
                  });
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const MyDatePicker(
              labelText: 'موعد البدء',
            ),
            const SizedBox(
              height: 5,
            ),
            const MyDatePicker(
              labelText: 'موعد الانتهاء',
            ),
            const SizedBox(
              height: 5,
            ),
            ElevatedButton(
                onPressed: () {
                  //  formKey.currentState!.save();
                },
                child: const Text('إضافة المهمة')),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
