import 'package:flutter/material.dart';
import 'package:organize_me/constants.dart';
import 'package:organize_me/scrns_and_widgets/icon_Form.dart';

import 'input_text.dart';

class Login extends StatelessWidget {
  const Login(
      {super.key,
      this.savePassword,
      this.userNameValidator,
      this.passwordValidator,
      this.saveEmail,
      this.saveUserName,
      this.emailValidator});

  final Function(String?)? savePassword;
  final Function(String?)? saveEmail;
  final Function(String?)? saveUserName;
  final String? Function(String?)? userNameValidator;
  final String? Function(String?)? passwordValidator;
  final String? Function(String?)? emailValidator;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const IconForm(
                child: Icon(
              Icons.person_outlined,
              size: 50,
            )),
            const SizedBox(
              height: 15,
            ),
            const Text(
              ' سجل دخول',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InputText(
                hint: 'ايميل',
                save: saveEmail,
                validator: emailValidator,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InputText(
                hint: 'كلمة السر',
                save: savePassword,
                validator: passwordValidator,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: appColorTheme, shape: const StadiumBorder()),
              onPressed: () {
                print('hello');
              },
              child: const Text(
                'سجل دخول',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
