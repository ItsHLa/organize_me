import 'package:flutter/material.dart';
import 'package:organize_me/constants.dart';
import 'package:organize_me/scrns_and_widgets/icon_Form.dart';

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
    return AlertDialog(
        content: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        const IconForm(
            child: Icon(
          Icons.phone_android_outlined,
          size: 50,
        )),
        const SizedBox(
          height: 15,
        ),
        const Text(
          'هل تريد ربط فواتيرك برقم هاتفك ؟',
          textAlign: TextAlign.center,
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
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: appColorTheme, shape: const StadiumBorder()),
          onPressed: () {
            print('hello');
          },
          child: const Text(
            'اوافق',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
        ));
  }
}
