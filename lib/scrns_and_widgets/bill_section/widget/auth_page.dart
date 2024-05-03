import 'package:flutter/material.dart';
import 'package:organize_me/constants.dart';

import '../../input_text.dart';

class Auth extends StatelessWidget {
  const Auth(
      {super.key,
      this.saveName,
      this.savePhoneNumber,
      this.nameValidator,
      this.phoneNumberValidator});

  final Function(String?)? saveName;
  final Function(String?)? savePhoneNumber;
  final String? Function(String?)? nameValidator;
  final String? Function(String?)? phoneNumberValidator;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Text(
              'هل تريد ربط فواتيرك برقم هاتفك ؟',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InputText(
                keyboardType: TextInputType.phone,
                hint: 'الرقم',
                save: savePhoneNumber,
                validator: phoneNumberValidator,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              decoration: BoxDecoration(color: softPurple),
              child: ElevatedButton(
                onPressed: () {
                  print('hello');
                },
                child: Text('اوافق'),
              ),
            ),
          ],
        ));
  }
}
