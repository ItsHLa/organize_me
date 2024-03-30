import 'package:flutter/material.dart';
import 'package:organize_me/input_text.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      Container(
        child:const Column(
          children: [
            Text('مرحبا بك في OrganizeMe حيث امورك المهمة في مكان واحد'),
            Text('كل مواعيدك و ملاحظاتك و فواتيرك في مكان واحد '),
            InputText(hint: 'ادخل رقم الباركود'),
            InputText(hint: 'ادحل رقم العداد'),

          ],
        ),
      ),
    );
  }
}
