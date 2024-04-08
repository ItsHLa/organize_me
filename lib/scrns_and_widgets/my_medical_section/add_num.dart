import 'package:flutter/material.dart';
import 'package:organize_me/scrns_and_widgets/input_text.dart';

class AddNumber extends StatefulWidget {
  const AddNumber({super.key});

  @override
  State<AddNumber> createState() => _AddNumberState();
}

class _AddNumberState extends State<AddNumber> {
  GlobalKey<FormState> numKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: 8, right: 8, bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Form(
          key: numKey,
          child: const Column(
            children: [
              SizedBox(
                height: 15,
              ),
              InputText(hint: 'الاسم'),
              SizedBox(
                height: 5,
              ),
              InputText(hint: 'الرقم'),
              SizedBox(
                height: 5,
              ),
              ElevatedButton(onPressed: null, child: Icon(Icons.add)),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
