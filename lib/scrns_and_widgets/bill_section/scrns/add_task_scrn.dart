import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../input_text.dart';


class AddTaskScrn extends StatefulWidget {
  const AddTaskScrn({super.key});

  @override
  State<AddTaskScrn> createState() => _AddTaskScrnState();
}

class _AddTaskScrnState extends State<AddTaskScrn> {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? taskName;
  String? startDate;
  String? startTime;
  String? endDate;
  String? endTime;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body:  Column(
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
             save: (value){
               setState(() {
                 taskName = value!;
               });

             },
           ),
         ),
         const SizedBox(height: 10,),
         ElevatedButton(onPressed: (){
           //  formKey.currentState!.save();

         }, child: const Text('إضافة المهمة')),
         const SizedBox(height: 15,),
       ],
      ),
    );
  }
}
