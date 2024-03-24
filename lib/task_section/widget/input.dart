import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'inputText.dart';

class Input extends StatefulWidget {
  Input({super.key , required this.title , required this.content ,required this.action , required this.icon });
  String title;
  String content ;
  String action ;
  IconData icon;
  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  late String? taskName;
  late String? description;
  AutovalidateMode validateMode = AutovalidateMode.disabled;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool validate (GlobalKey<FormState> key){
    if( key.currentState!.validate()){
      return true;
    }else{
      return false ;
    }
  }




  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Form(
        autovalidateMode: validateMode,
        key: formKey,
        child: ListView(
          children: [
            const SizedBox(height: 30),
            InputText(hint :widget.title,
              save: (value) {
                taskName = value;
              },
            ),
            const SizedBox(height: 10),
            InputText(hint: widget.content, lines: 5,
            save: ( value ) => description = value ,),
            const SizedBox(height: 10),
            ElevatedButton.icon(
                onPressed: (){
              if(
              validate(formKey)
              ){
                formKey.currentState!.save();
              }else{
                validateMode = AutovalidateMode.always;
              }
             // addTask

            }
            , icon: Icon(widget.icon), label: Text(widget.action))
          ],
        ),
      ),
    );
  }
}