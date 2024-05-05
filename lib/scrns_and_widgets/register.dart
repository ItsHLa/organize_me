import 'package:flutter/material.dart';
import 'package:organize_me/constants.dart';
import 'package:organize_me/home_page.dart';
import 'package:organize_me/scrns_and_widgets/icon_Form.dart';
import 'package:organize_me/scrns_and_widgets/login.dart';
import 'package:organize_me/services/api_calls.dart';
import 'package:http/http.dart';

import '../services/functionality.dart';
import '../user.dart';
import 'input_text.dart';

class Register extends StatefulWidget {
  const Register({
    super.key,
  });

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  GlobalKey<FormState> userKey = GlobalKey();
  String userName = '';
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Form(
          key: userKey,
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
                'هل تريد ربط فواتيرك بعنوان بريدك الالكتروني ؟',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                ' انشىء حساب',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InputText(
                  labelText: 'اسم المستخدم',
                  save: (value) {
                    setState(() {
                      userName = value!;
                    });
                  },
                  validator: ValidateInputData.checkIfNull,
                  hint: '',
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InputText(
                  labelText: 'ايميل',
                  save: (value) {
                    setState(() {
                      email = value!;
                    });
                  },
                  validator: ValidateInputData.validateEmail,
                  hint: '',
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InputText(
                  labelText: 'كلمة السر',
                  save: (value) {
                    setState(() {
                      password = value!;
                    });
                  },
                  validator: ValidateInputData.validatePassword,
                  hint: '',
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    child: Text(
                      'سجل دخول',
                      style: TextStyle(color: appColorTheme),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Login()));
                      // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Login()));
                    },
                  ),
                  const Text('لديك حساب مسبقا؟'),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: appColorTheme,
                  shape: const StadiumBorder(),
                ),
                onPressed: () async {
                  if (ValidateInputData.validateField(userKey)) {
                    userKey.currentState?.save();
                    await User.setUserInfo(
                      userName: userName,
                      email: email,
                      password: password,
                    );
                    Response r = await addUser(
                      User(
                        email: email,
                        password: password,
                        username: userName,
                      ),
                    );
                    print(r);
                    // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomePage()));
                    if (context.mounted) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    }
                  }
                },
                child: const Text(
                  'انشئ حساب',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
